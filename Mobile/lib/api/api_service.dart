import 'dart:convert';
import 'dart:developer';

import 'package:relax/app_config.dart';
import 'package:relax/models/message.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Future<List<Message>?> getResponse() async {
  //   try {
  //     var url = Uri.parse(AppConfig.BASE_URL + '/api/ask');
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<Message> _model = messageFromJson(response.body);
  //       return _model;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<Message> sendMessage(
     String uID, String type, String say) async {
    final http.Response response = await http.post(
      Uri.parse(AppConfig.BASE_URL + 'ask'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'uID': uID,
        'type': type,
        'say': say,
        // 'audioURL': audioURL,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Message.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
