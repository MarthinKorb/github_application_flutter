import 'package:github_application_flutter/modules/user/domain/models/user.dart';
import 'package:github_application_flutter/modules/user/domain/models/user_repositories.dart';

abstract class IUserRepository {
  Future<List<User>> findByName(String userName);
  Future<User> findByUrl(String url);
  Future<List<UserRepositories>> getUserRepositories(String url);
}
