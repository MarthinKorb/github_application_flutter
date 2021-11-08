import 'package:flutter/material.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';

class UserAvatarHeroPage extends StatelessWidget {
  final UserResponse user;
  const UserAvatarHeroPage({@required this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name ?? user.login), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: InteractiveViewer(
          child: Hero(
            tag: user.login,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(user.avatarUrl),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
