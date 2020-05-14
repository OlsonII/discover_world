import 'package:discover_world/src/presentation/pages/detail_event_page.dart';
import 'package:discover_world/src/presentation/pages/detail_history_page.dart';
import 'package:discover_world/src/presentation/pages/detail_info_location_page.dart';
import 'package:discover_world/src/presentation/pages/detail_location_page.dart';
import 'package:discover_world/src/presentation/pages/detail_site_page.dart';
import 'package:discover_world/src/presentation/pages/location_map_page.dart';
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
        fontFamily: 'ProductSans'
      ),
      onGenerateRoute: (setting){
        switch(setting.name){
          case '/details_location':
            routeGenerator(DetailLocationPage());
            break;
          case '/details_site':
            routeGenerator(DetailSitePage());
            break;
          case '/details_event':
            routeGenerator(DetailEventPage());
            break;
          case '/details_history':
            routeGenerator(DetailHistoryPage());
            break;
          case '/search_location':
            routeGenerator(SearchLocationPage());
            break;
          case '/location_map':
            routeGenerator(LocationMapPage());
            break;
        }
        return null;
      },
      initialRoute: '/search_location',
      routes: {
        '/details_location'       : (BuildContext context) => DetailLocationPage(),
        '/details_site'         : (BuildContext context) => DetailSitePage(),
        '/details_event'        : (BuildContext context) => DetailEventPage(),
        '/details_history'      : (BuildContext context) => DetailHistoryPage(),
        '/search_location'      : (BuildContext context) => SearchLocationPage(),
        '/location_map'         : (BuildContext context) => LocationMapPage(),
        '/detail_info_location' : (BuildContext context) => DetailInfoLocationPage()
      },
    );
  }

  routeGenerator(Widget page){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var curveTween = CurveTween(curve: curve);
        var tween = Tween(begin: begin, end: end).chain(curveTween);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}