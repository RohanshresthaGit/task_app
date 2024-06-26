
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/help_page.dart';
import 'package:flutter_task/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/helpPage',
      routes: {
        '/helpPage': (context) => const HelpPage(),
        '/homePage' :(context) => const HomePage()
      },
    );
  }
}
