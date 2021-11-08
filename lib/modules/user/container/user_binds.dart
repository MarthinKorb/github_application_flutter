import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_application_flutter/modules/user/application/user_service.dart';
import 'package:github_application_flutter/modules/user/domain/repositories/i_user_repository.dart';
import 'package:github_application_flutter/modules/user/infra/repositories/user_repository_impl.dart';
import 'package:github_application_flutter/modules/user/ui/bloc/search_user_bloc.dart';

List<Bind> get userBinds => [
      Bind.lazySingleton<IUserRepository>((i) => UserRepositoryImpl(dio: i())),
      Bind.lazySingleton<UserService>((i) => UserService(userRepository: i())),
      Bind.lazySingleton<SearchUserBloc>(
          (i) => SearchUserBloc(userService: i())),
    ];
