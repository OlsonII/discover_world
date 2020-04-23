import 'package:discover_world/src/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class DetailEventPage extends StatefulWidget {
  @override
  _DetailEventPageState createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {

  Size _screenSize;
  Event _event;
  Color  _starColor = Color.fromRGBO(244, 100, 82, 1);
  Color _endColor = Color.fromRGBO(254, 126, 110, 1);
  int _selectedSubPage = 0;
  List<Widget> _pages;


  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _event = ModalRoute.of(context).settings.arguments;
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
          _buildBodyButtons(),
          SizedBox(height: _screenSize.height*0.02),
          _buildContentBody()
        ],
      ),
    );
  }

  Row _buildBodyButtons() {
    return Row(
      children: <Widget>[
        Expanded(child: Container(),),
        _buildInfoButton(),
        _buildUbicationButton(),
        Expanded(child: Container(),),
      ],
    );
  }

  Expanded _buildContentBody() {
    return Expanded(
      child: Container(
        child: _pages[_selectedSubPage],
      ),
    );
  }

  Padding _buildBodyTittle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text('Explora aqui', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
      ),
    );
  }

  Container _buildUbicationButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(76, 175, 80, 0.4),
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        shape: CircleBorder(),
        child: FaIcon(FontAwesomeIcons.mapMarker, color: Colors.green),
        onPressed: (){
          setState(() {
            _selectedSubPage = 1;
          });
        },
      ),
    );
  }

  Container _buildInfoButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(34, 150, 243, 0.4),
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        shape: CircleBorder(),
        child: FaIcon(FontAwesomeIcons.info, color: Colors.blue),
        onPressed: (){
          setState(() {
            _selectedSubPage = 0;
          });
        },
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
                child: Text(_event.name, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('${_event.initialDate} - ${_event.endDate}', style: TextStyle(fontSize: 17.0))
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(_event.description, style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
