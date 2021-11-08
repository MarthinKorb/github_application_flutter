import 'package:flutter/material.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';
import 'package:github_application_flutter/shared/app_routes.dart';

class UserTileWidget extends StatefulWidget {
  final UserResponse user;
  const UserTileWidget({@required this.user, Key key}) : super(key: key);

  @override
  _UserTileWidgetState createState() => _UserTileWidgetState();
}

class _UserTileWidgetState extends State<UserTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.userDetailsPage,
        arguments: widget.user,
      ),
      child: Card(
        elevation: 0.5,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.user.avatarUrl),
          ),
          title: Text(widget.user.name ?? widget.user.login),
          // trailing: const Icon(Icons.navigate_next),
          trailing: PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 1:
                  Navigator.pushNamed(
                    context,
                    AppRoutes.userDetailsPage,
                    arguments: widget.user,
                  );
                  break;
                case 2:
                  Navigator.pushNamed(
                    context,
                    AppRoutes.userRepositoriesPage,
                    arguments: widget.user,
                  );
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text('Details'),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text('Repositories'),
                  value: 2,
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
