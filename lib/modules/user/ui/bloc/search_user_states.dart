import 'package:github_application_flutter/modules/user/domain/errors/erros.dart';
import 'package:github_application_flutter/modules/user/domain/models/user.dart';

abstract class SearchUserState {}

class StartState implements SearchUserState {
  const StartState();
}

class LoadingState implements SearchUserState {
  const LoadingState();
}

class ErrorState implements SearchUserState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements SearchUserState {
  final User user;
  const SuccessState(this.user);
}
