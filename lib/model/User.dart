
class User_Model {
  String id;
  final String name;
  final String photo;

  User_Model({this.id = '', required this.name, required this.photo});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'photo': photo,
  };

  static User_Model fromJson(Map<String, dynamic> json) => User_Model(

     //id: json['id_user'],
      name: json['name'],
      photo: json['photo']);
}