import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.123:8000'));

  Future<String> analyze(String type, String path) async {
    final resp = await dio.post('/analyze',
        data: FormData.fromMap({
          'type': type,
          'file': await MultipartFile.fromFile(path)
        }));
    return resp.data['class'] as String;
  }
}
