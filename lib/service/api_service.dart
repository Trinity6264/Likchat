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
        {
          "model": "text-davinci-003",
          "prompt": prompt,
          "max_tokens": 600,
        },
      ),
    );
    return resp;
  }
}
