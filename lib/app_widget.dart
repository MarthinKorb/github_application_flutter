import 'package:flutter/material.dart';
import 'package:github_application_flutter/modules/pages/initial_page.dart';
import 'package:github_application_flutter/modules/user/ui/pages/user_details_page.dart';
import 'package:github_application_flutter/modules/user/ui/pages/user_repositories_page.dart';
import 'package:github_application_flutter/shared/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.initialPage,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      routes: {
        AppRoutes.initialPage: (context) => InitialPage(key: key),
        AppRoutes.userDetailsPage: (context) => UserDetailsPage(key: key),
        AppRoutes.userRepositoriesPage: (context) =>
            UserRepositoriesPage(key: key),
      },
    );
  }
}
