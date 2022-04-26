import 'package:flutter/material.dart';
import 'package:flutter_cool_toolbar_practice/widgets/cool_toolbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: CoolToolbar(),
      )),
    );
  }
}
