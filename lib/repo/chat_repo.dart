import 'dart:convert';
import 'dart:developer';

import 'package:likchat/model/chat_model.dart';
import 'package:likchat/service/api_service.dart';

class ChatRepo {
  final ApiService apiService = ApiService();

  Future<ChatModel?> sendChat(String prompt) async {
    final res = await apiService.sendRequest(prompt);
    if (res.statusCode != 200) throw Exception();
    final resp = jsonDecode(res.body);
    log(resp);
    return null;
  }
}
