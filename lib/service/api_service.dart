import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiService {
  static const baseUrl = 'https://api.openai.com/v1/completions';
  final token = dotenv.env['API_KEY'];

  Future<http.Response> sendRequest(String prompt) async {
    final resp = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token',
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
