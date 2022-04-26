import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cool_toolbar_practice/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'TitilliumWeb',
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          )),
      home: const HomeScreen(),
    );
  }
}
