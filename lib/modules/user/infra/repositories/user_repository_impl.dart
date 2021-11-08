import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:github_application_flutter/modules/user/domain/models/user.dart';
import 'package:github_application_flutter/modules/user/domain/models/user_repositories.dart';
import 'package:github_application_flutter/modules/user/domain/repositories/i_user_repository.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';
import 'package:github_application_flutter/shared/constants.dart';

class UserRepositoryImpl implements IUserRepository {
  Dio _dio;

  UserRepositoryImpl({@required Dio dio}) {
    _dio = dio;
  }

  @override
  Future<List<UserResponse>> findByName(String userName) async {
    var usersList = <User>[];
    final response = await _dio
        .get('$apiUrl/search/users?q=${userName.trim().replaceAll(' ', '+')}');
    var jsonList = response.data['items'] as List;
    usersList = jsonList.map((user) => UserResponse.fromMap(user)).toList();

    return usersList;
  }

  @override
  Future<UserResponse> findByUrl(String url) async {
    final response = await _dio.get(url);
    return UserResponse.fromMap(response.data);
  }

  @override
  Future<List<UserRepositories>> getUserRepositories(String url) async {
    final response = await _dio.get(url);
    return (response.data as List)
        .map((map) => UserRepositories.fromMap(map))
        .toList();
  }
}
