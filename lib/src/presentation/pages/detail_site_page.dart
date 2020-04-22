import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class DetailSitePage extends StatelessWidget {

  Size _screenSize;
  Color _starColor = Color.fromRGBO(55, 157, 168, 1);
  Color _endColor = Color.fromRGBO(99, 196, 207, 1);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(
          colors: [
            _starColor,
            _endColor
          ]
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: _screenSize.height*0.25,
              child: Image.asset('assets/images.png'),
            )
          ],
        ),
      )
    );
  }
}
