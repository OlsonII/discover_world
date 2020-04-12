import 'package:flutter/material.dart';

class SearchLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue,
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.cyan
                ],
                stops: [0.0, 0.9]
            )
        )
    );
  }
}
