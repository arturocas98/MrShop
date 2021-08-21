import 'package:flutter/material.dart';
import 'package:mr_shop/src/pages/login/login_page.dart';
import 'package:mr_shop/src/pages/register/register_page.dart';
import 'package:mr_shop/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr Shop',
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      routes:{
       'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage()
      },
      theme: (
        ThemeData(

          primaryColor: MyColors.primaryColor
        )
      ),
    );
  }
}

