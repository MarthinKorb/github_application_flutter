import 'package:flutter/foundation.dart';
import 'package:github_application_flutter/modules/user/domain/models/user_repositories.dart';
import 'package:github_application_flutter/modules/user/domain/repositories/i_user_repository.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';

class UserService {
  IUserRepository _userRepository;

  UserService({@required IUserRepository userRepository}) {
    _userRepository = userRepository;
  }

  Future<List<UserResponse>> findByName(String name) async {
    return await _userRepository.findByName(name);
  }

  Future<UserResponse> findByUrl(String url) async {
    return await _userRepository.findByUrl(url);
  }

  Future<List<UserRepositories>> getRepositories(String url) async {
    final response = await _userRepository.getUserRepositories(url);

    return response
      ..sort(
        (a, b) => b.stargazersCount.compareTo(a.stargazersCount),
      );
  }
}
