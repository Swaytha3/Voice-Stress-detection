// ignore_for_file: invalid_required_named_param
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Message {
  // final String uID;
  final String type;
  final String say;
  final DateTime date;

  
  Message({
    // @required this.uID = '',
    @required this.type = 'text',
    @required this.say = '',
    DateTime? date,    
  }): this.date = date ?? DateTime.now();

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        // uID: json["uID"],
        type: json["type"] == "audio"? "audio" :'text',
        say: json["response"],
        // audioURL: json["audioURL"]
      );

  Map<String, dynamic> toJson() => {
        // "uID": uID,
        "type": type,
        "say": say,
        // "audioURL": audioURL,
      };
}
