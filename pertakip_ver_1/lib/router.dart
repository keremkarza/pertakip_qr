import 'package:flutter/material.dart';
import 'package:pertakip_ver_1/routing_constants.dart';
import 'package:pertakip_ver_1/screens/all_database_page.dart';
import 'package:pertakip_ver_1/screens/manager_page.dart';
import 'package:pertakip_ver_1/screens/personal_database_page.dart';
import 'package:pertakip_ver_1/screens/personal_page.dart';
import 'package:pertakip_ver_1/screens/undefined_page.dart';

import 'screens/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPageRoute:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case ManagerPageRoute:
      return MaterialPageRoute(builder: (context) => ManagerPage());
    case PersonalPageRoute:
      return MaterialPageRoute(builder: (context) => PersonalPage());
    case AllDatabasePageRoute:
      return MaterialPageRoute(builder: (context) => AllDatabasePage());
    case PersonalDatabasePageRoute:
      return MaterialPageRoute(
          builder: (context) =>
              PersonalDatabasePage(activePerson: settings.arguments));
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedPage(name: settings.name));
  }
}
