import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String idUser;
  final String urlAvatar;
  final String username;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.idUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
  required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
    idUser: json['id_user'],
    urlAvatar: json['photo'],
    username: json['name'],
    message: json['message'],
   createdAt: Utils.toDateTime(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id_user': idUser,
    'photo': urlAvatar,
    'name': username,
    'message': message,
  'createdAt': Utils.fromDateTimeToJson(createdAt),
  };
}