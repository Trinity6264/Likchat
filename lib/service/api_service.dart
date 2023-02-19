import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://api.openai.com/v1/completions';

  Future<http.Response> sendRequest(String prompt) async {
    final resp = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: json.encode(
        {"model": "text-davinci-003", "prompt": prompt, "max_tokens": 600},
      ),
    );
    return resp;
  }
}
