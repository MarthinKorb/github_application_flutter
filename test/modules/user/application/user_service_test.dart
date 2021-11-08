import 'package:flutter_test/flutter_test.dart';
import 'package:github_application_flutter/modules/user/application/user_service.dart';
import 'package:github_application_flutter/modules/user/domain/models/user.dart';
import 'package:github_application_flutter/modules/user/domain/repositories/i_user_repository.dart';
import 'package:mockito/mockito.dart';

import '../domain/repositories/user_repository_mock.dart';

void main() {
  UserService userService;
  IUserRepository userRepository;
  List<User> users;

  setUpAll(() {
    userRepository = UserRepositoryMock();
    userService = UserService(userRepository: userRepository);
    users = [User(login: 'John Duo')];
  });
  group('Tests of UserService class => ', () {
    test('it should find a user by it\'s name', () async {
      when(userRepository.findByName('John Duo'))
          .thenAnswer((_) async => users);
      final usersFound = await userService.findByName('John Duo');
      expect(usersFound, isA<List<User>>());
      expect(usersFound.length, equals(1));
    });
  });
}
