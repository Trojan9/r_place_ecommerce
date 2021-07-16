import 'package:flutter/material.dart';
import 'package:r_place/Screens/carts.dart';
import 'package:r_place/Screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "R's place.com",
      initialRoute: "/",
      routes: {
        '/': (context) => Cartproducts(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Homepage(),
    );
  }
}
