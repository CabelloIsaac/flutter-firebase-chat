import 'dart:convert';

DBUser userFromJson(String str) => DBUser.fromJson(json.decode(str));

String userToJson(DBUser data) => json.encode(data.toJson());

class DBUser {
  DBUser({
    this.name,
    this.lastName,
    this.email,
    this.avatar,
  });

  String name;
  String lastName;
  String email;
  String avatar;

  factory DBUser.fromJson(Map<String, dynamic> json) => DBUser(
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "avatar": avatar,
      };
}
