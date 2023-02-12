import 'package:flutter/material.dart';
import 'package:pertakip_ver_1/models/active_person.dart';
import 'package:pertakip_ver_1/models/persons_data.dart';
import 'package:pertakip_ver_1/screens/manager_page.dart';
import 'package:provider/provider.dart';

import 'models/color_theme_data.dart';
import 'models/pages_data.dart';
import 'models/records_data.dart';
import 'models/todays_records_data.dart';
import 'router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodaysRecordData().createPrefObject();
  await RecordData().createPrefObject();
  await PersonsData().createPrefObject();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodaysRecordData>(
          create: (BuildContext context) => TodaysRecordData(),
        ),
        ChangeNotifierProvider<ColorThemeData>(
          create: (BuildContext context) => ColorThemeData(),
        ),
        ChangeNotifierProvider<PageData>(
          create: (BuildContext context) => PageData(),
        ),
        ChangeNotifierProvider<ActivePerson>(
          create: (BuildContext context) => ActivePerson(),
        ),
        ChangeNotifierProvider<PersonsData>(
          create: (BuildContext context) => PersonsData(),
        ),
        ChangeNotifierProvider<RecordData>(
          create: (BuildContext context) => RecordData(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pertakip App',
      theme: ColorThemeData().orangeTheme,
      home: ManagerPage(),
      onGenerateRoute: router.generateRoute,
    );
  }
}
