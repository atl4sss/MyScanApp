// lib/core/inference.dart
import 'dart:typed_data';
import 'dart:math';
import 'package:pytorch_lite/pytorch_lite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/* ───── метки классов ───── */
const _labels = <String, List<String>>{
  'lungs': ['Норма', 'Пневмония'],
  'oct': ['CNV', 'DME', 'Drusen', 'Норма'],
  'brain': ['Глиома', 'Менингиома', 'Питуитарная', 'Без опухоли'],
};

class LocalAI {
  LocalAI._();
  static final _instance = LocalAI._();
  factory LocalAI() => _instance;

  /* кэш: id → ClassificationModel */
  final Map<String, ClassificationModel> _cache = {};

  /* ——— utils ——— */
  Future<String> _saveModelToFile(String id) async {
    final bytes = await rootBundle.load('assets/models/$id.pt');
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$id.pt');
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    return file.path;
  }

Future<ClassificationModel> _load(String id) async {
  final model = await PytorchLite.loadClassificationModel(
    'assets/models/$id.pt', // Прямой путь
    224,
    224,
    _labels[id]!.length,
  );
  return model;
}
  /* ——— /utils ——— */

  /// Выполняет оффлайн-инференс и возвращает (метка, вероятность)
  Future<(String, double)> predict(String id, Uint8List imageBytes) async {
    if (!_labels.containsKey(id)) {
      throw ArgumentError('Unknown modality id: $id');
    }

    final model = await _load(id);
    
    // Получаем предсказания модели
    final predictions = await model.getImagePredictionList(
      imageBytes,
    );

    // Убрали проверку на null (теперь проверяем только на пустоту)
    if (predictions.isEmpty) {
      throw Exception('Model returned no predictions');
    }

    // Находим индекс с максимальным значением
    double maxVal = predictions[0];
    int maxIndex = 0;
    for (int i = 1; i < predictions.length; i++) {
      if (predictions[i] > maxVal) {
        maxVal = predictions[i];
        maxIndex = i;
      }
    }

    // Применяем softmax для получения вероятности
    double sum = 0;
    for (final p in predictions) {
      sum += exp(p);
    }
    final probability = exp(maxVal) / sum;

    return (_labels[id]![maxIndex], probability);
  }
}