import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_application_flutter/modules/user/container/user_binds.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        ...userBinds,
      ];
}
