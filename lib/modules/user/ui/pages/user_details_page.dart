import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_application_flutter/modules/user/application/user_service.dart';
import 'package:github_application_flutter/modules/user/domain/models/user.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';
import 'package:github_application_flutter/modules/user/ui/pages/user_avatar_hero_page.dart';
import 'package:github_application_flutter/shared/app_routes.dart';
import 'package:github_application_flutter/shared/widgets/button_widget.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as User;
    final userService = Modular.get<UserService>();

    return Scaffold(
      appBar: AppBar(title: Text(user.login), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<UserResponse>(
                future: userService.findByUrl(user.url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.hasError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: Text(
                            'Sorry, it was not possible to load user information...'),
                      ),
                    );
                  }

                  final _user = snapshot.data;
                  return Column(
                    children: [
                      _buildUserImageContainer(context, _user),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _user.name ?? _user.login,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: 1,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                        child: Text(_user.bio ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.green),
                            Text(_user.location ?? 'Not found'),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfosContainer(
                            icon: Icons.directions_run_outlined,
                            title: 'Followers',
                            info: _user.followers.toString(),
                          ),
                          const SizedBox(width: 50),
                          _buildInfosContainer(
                            icon: Icons.group_add_rounded,
                            title: 'Following',
                            info: _user.following.toString(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.book_rounded, color: Colors.green),
                            const SizedBox(width: 4),
                            const Text('Public Repos: '),
                            Text(_user.publicRepos.toString()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ButtonWidget(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.userRepositoriesPage,
                          arguments: _user,
                        ),
                        title: 'Navigate to ${user.login} repositories',
                        icon: Icons.navigate_next_outlined,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfosContainer({
    @required IconData icon,
    @required String title,
    @required String info,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green),
            Text(title),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          info,
          style: const TextStyle(color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildUserImageContainer(BuildContext context, UserResponse user) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserAvatarHeroPage(
              user: user,
            ),
          ),
        );
      },
      child: Hero(
        tag: user.login,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage(user.avatarUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
