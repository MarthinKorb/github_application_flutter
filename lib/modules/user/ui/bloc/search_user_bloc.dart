import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:github_application_flutter/modules/user/application/user_service.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';

class SearchUserBloc {
  UserService _userService;

  SearchUserBloc({@required UserService userService}) {
    _userService = userService;
  }

  final StreamController<String> _streamController =
      StreamController.broadcast();

  Sink<String> get inputUserName => _streamController.sink;

  Stream<List<UserResponse>> get outputUsers =>
      _streamController.stream.asyncMap((userName) => _findUsers(userName));

  Future<List<UserResponse>> _findUsers(String userName) async {
    final res = await _userService.findByName(userName);
    return res;
  }

  void dispose() {
    _streamController.close();
  }
}
