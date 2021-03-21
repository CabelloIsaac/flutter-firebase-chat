import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';

class UserItem extends StatelessWidget {
  const UserItem(this.user);
  final DBUser user;
  @override
  Widget build(BuildContext context) {
    bool userHasValidAvatar = _userHasValidAvatar();
    print(user.toJson());
    return ListTile(
      leading: CircleAvatar(
        child: !userHasValidAvatar ? Icon(Icons.person) : null,
        backgroundImage: userHasValidAvatar ? NetworkImage(user.avatar) : null,
      ),
      title: Text(getUserName()),
      onTap: () {},
    );
  }

  bool _userHasValidAvatar() {
    String avatar = user.avatar;
    return avatar != null && avatar.isNotEmpty;
  }

  String getUserName() => "${user.name} ${user.lastName}";
}
