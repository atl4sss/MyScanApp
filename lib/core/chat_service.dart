import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  static final _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final _endpoint = Uri.parse('https://api.openai.com/v1/chat/completions');
  final _model    = 'gpt-4o-mini';

  Future<String> ask(String userPrompt) async {
    final key = dotenv.env['OPENAI_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('OPENAI_KEY not found in .env');
    }

    final body = jsonEncode({
      'model'   : _model,
      'messages': [
        {'role': 'user', 'content': userPrompt}
      ],
      'temperature': 0.7,
    });

    final res = await http.post(
      _endpoint,
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer $key',
      },
      body: body,
    );

    if (res.statusCode != 200) {
      throw Exception('OpenAI error ${res.statusCode}: ${res.body}');
    }

    final data   = jsonDecode(res.body);
    final answer = data['choices'][0]['message']['content'] as String;
    return answer.trim();
  }
}
