import 'package:discover_world/src/presentation/pages/detail_location_page.dart';
import 'package:discover_world/src/presentation/pages/search_location_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turist App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/details',
      routes: {
        '/details'     : (BuildContext context) => DetailLocationPage(),
        '/search' : (BuildContext context) => SearchLocationPage()
      },
    );
  }
}