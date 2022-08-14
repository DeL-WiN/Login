import 'package:flutter/material.dart';
import 'package:login_tutorial/controllers/login_controller.dart';
import 'package:login_tutorial/login_page.dart';
import 'package:login_tutorial/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  // UserProvider userP = UserProvider();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: LoginPage()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LoginPage(),
      ),
    );
  }
}

