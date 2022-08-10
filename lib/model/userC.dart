import 'package:meta/meta.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserC {
  final String idUser;
  final String name;
  final String urlAvatar;
  final DateTime lastMessageTime;

  const UserC({
    required this.idUser,
    required this.name,
    required this.urlAvatar,
    required this.lastMessageTime,
  });

  UserC copyWith({
    required String idUser,
    required String name,
    required String urlAvatar,
    required String lastMessageTime,
  }) =>
      UserC(
        idUser: /*idUser ??*/ this.idUser,
        name: /*name ??*/ this.name,
        urlAvatar: /*urlAvatar ?? */this.urlAvatar,
        lastMessageTime: this.lastMessageTime,
      );

  static UserC fromJson(Map<String, dynamic> json) => UserC(
        idUser: json['id_user'],
        name: json['name'],
        urlAvatar: json['photo'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'name': name,
        'photo': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
