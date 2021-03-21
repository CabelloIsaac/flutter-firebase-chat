class DBUser {
  DBUser({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.avatar,
  });

  String id;
  String name;
  String lastName;
  String email;
  String avatar;

  factory DBUser.fromJson({String id = "", Map<String, dynamic> data}) {
    print(data);
    return DBUser(
      id: id,
      name: data["name"],
      lastName: data["lastName"],
      email: data["email"],
      avatar: data["avatar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "avatar": avatar,
      };
}
