import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/domain/entities/site.dart';
import 'package:discover_world/src/presentation/colors/colors.dart';
import 'package:discover_world/src/presentation/pages/activities_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DetailSitePage extends StatefulWidget {

  @override
  _DetailSitePageState createState() => _DetailSitePageState();
}

class _DetailSitePageState extends State<DetailSitePage> {
  Size _screenSize;

  Site _site;
  Location _location;

  int _selectedSubPage = 0;

  List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    _site = arguments["Site"];
    _location = arguments["Location"];
    _pages = [
      _buildInfoContainer(),
      _site.activities != null ? ActivitiesPage(activities: _site.activities) : _noActivitiesText(),
      Container()
    ];
    return Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: <Widget>[
            _buildBackground(),
            Column(
              children: <Widget>[
                _buildPrincipalInformationContainer(),
                _buildSecondaryInformationContainer()
              ],
            )
          ],
        )
    );
  }

  _buildSecondaryInformationContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: _screenSize.height*0.45,
        margin: EdgeInsets.only(top: 30.0, left: 0.0, right: 0.0),
        padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))
        ),
        child: Column(
          children: <Widget>[
            _buildBodyTittle(),
            _buildBodyButtons(),
            SizedBox(height: _screenSize.height*0.02),
            _buildContentBody()
          ],
        ),
      ),
    );
  }

  Row _buildBodyButtons() {
    return Row(
      children: <Widget>[
        Expanded(child: Container(),),
        _buildInfoButton(),
        _buildActivitiesButton(),
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
            _selectedSubPage = 2;
            Navigator.pushNamed(context, '/location_map', arguments: {"Location": _location});
          });
        },
      ),
    );
  }

  Container _buildActivitiesButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 66, 53, 0.4),
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        shape: CircleBorder(),
        child: FaIcon(FontAwesomeIcons.running, color: Colors.red),
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  image: DecorationImage(
                    image: NetworkImage(_site.image),
                    fit: BoxFit.cover,
                  )
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_site.name, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_site.type, style: TextStyle(fontSize: 17.0))
            ),
          )
        ],
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.sitesColor
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: ThemeColors.principalColor,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: ThemeColors.iconsColors), onPressed: () => Navigator.of(context).pop()),
    );
  }

  Widget _buildInfoContainer(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(_site.description, style: TextStyle(fontSize: 16.0)),
      ),
    );
  }

  Widget _noActivitiesText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.center,
        child: Text('Este sitio no tiene actividades registradas', style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
