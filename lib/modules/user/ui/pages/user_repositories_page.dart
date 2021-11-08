import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_application_flutter/modules/user/application/user_service.dart';
import 'package:github_application_flutter/modules/user/domain/models/user_repositories.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';

class UserRepositoriesPage extends StatelessWidget {
  const UserRepositoriesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as UserResponse;
    final userService = Modular.get<UserService>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${user?.login ?? user.name}\'s repositories'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserRepositories>>(
              future: userService.getRepositories(user.reposUrl),
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

                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        'Repositories not found to ${user.name ?? user.login}...',
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final repository = snapshot.data[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              repository.owner.avatarUrl,
                            ),
                          ),
                          title: Text(repository.fullName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(repository.language ?? ''),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.green,
                                    size: 14,
                                  ),
                                  Text(repository.stargazersCount.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
