import 'package:discover_world/src/domain/entities/history.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class DetailHistoryPage extends StatefulWidget {
  @override
  _DetailHistoryPageState createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {

  Size _screenSize;
  History _history;
  Color  _starColor = Color.fromRGBO(113, 120, 211, 1);
  Color _endColor = Color.fromRGBO(137, 143, 223, 1);
  int _selectedSubPage = 0;
  List<Widget> _pages;

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _history = ModalRoute.of(context).settings.arguments;
    _pages = [
      _buildInfoContainer(),
      Container()
    ];

    return Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: <Widget>[
            _buildBackground(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildPrincipalInformationContainer(),
                  _buildSecondaryInformationContainer()
                ],
              ),
            )
          ],
        )
    );
  }

  Container _buildSecondaryInformationContainer() {
    return Container(
      width: double.infinity,
      height: _screenSize.height*0.45,
      margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0)
      ),
      child: Column(
        children: <Widget>[
          _buildBodyTittle(),
          SizedBox(height: _screenSize.height*0.002),
          _buildInfoContainer()
        ],
      ),
    );
  }

  Padding _buildBodyTittle() {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: Center(
        child: Text('Contenido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      ),
    );
  }

  Container _buildPrincipalInformationContainer() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      height: _screenSize.height*0.35,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0)
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: _screenSize.height*0.25,
            child: Image.asset('assets/images.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_history.name, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('${_history.type}', style: TextStyle(fontSize: 17.0))
            ),
          )
        ],
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              _starColor,
              _endColor
            ],
            stops: [0.0, 0.95]
        ),

      ),
    );
  }

  GradientAppBar _buildAppBar() {
    return GradientAppBar(
      gradient: LinearGradient(
          colors: [
            _starColor,
            _endColor
          ],
          stops: [0.0, 0.95]
      ),
      elevation: 0.0,
    );
  }

  Widget _buildInfoContainer(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(_history.content, style: TextStyle(fontSize: 16.0)),
        ),
      ),
    );
  }
}
