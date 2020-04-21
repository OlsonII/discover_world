import 'package:discover_world/src/aplication/bloc/location_bloc.dart';
import 'package:discover_world/src/aplication/bloc/location_event.dart';
import 'package:discover_world/src/aplication/bloc/location_state.dart';
import 'package:discover_world/src/presentation/pages/activities_page.dart';
import 'package:discover_world/src/presentation/pages/events_page.dart';
import 'package:discover_world/src/presentation/pages/histories_page.dart';
import 'package:discover_world/src/presentation/pages/sites_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailLocationPage extends StatefulWidget {

  DetailLocationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailLocationPageState createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {

  Size _screenSize;
  bool _isCollapsed = false;
  Duration _animationDuration = Duration(milliseconds: 400);
  String locationSelected = 'Valledupar';
  int _selectedPage = 0;
  List<Widget> _pages;
  Color _starColor = Colors.blue;
  Color _endColor = Colors.cyan;

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    locationBloc.sendLocationEvent.add(GetLocation(locationName: locationSelected));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackgroundColor(),
          _buildLateralMenu(),
          _buildContent()
        ],
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedPositioned(
      top: _isCollapsed ? _screenSize.height * 0.2 : 0,
      bottom: _isCollapsed ? _screenSize.width * 0.2 : 0,
      left: _isCollapsed ? _screenSize.width * 0.6 : 0,
      right: _isCollapsed ? _screenSize.width * -0.4 : 0,
      duration: _animationDuration,
      curve: Curves.fastOutSlowIn,
      child: Container(
        child: Column(
          children: <Widget>[
            _buildBack(),
            _buildPrincipalContainer(),
          ],
        ),
      ),
    );
  }

  _buildBackgroundColor(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  _starColor,
                  _endColor
                ],
                stops: [0.0, 0.9]
            )
        )
    );
  }

  _buildLateralMenu(){
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.5,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Mapa', style: TextStyle(fontSize: 20, color: Colors.white))),
                onPressed: (){},
              ),
            ),
            Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.5,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Explorar otra', style: TextStyle(fontSize: 20, color: Colors.white))),
                onPressed: (){},
              ),
            ),
            Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.5,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Salir', style: TextStyle(fontSize: 20, color: Colors.white))),
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBack(){
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(top: 50.0, left: 17.0, right: 17.0),
                    child: Icon(Icons.menu, size: 27.0, color: Colors.white)
                ),
                onTap: (){
                  setState(() {
                    _isCollapsed = !_isCollapsed;
                  });
                },
              ),
              _buildSearchBar(),
            ],
          ),
          _buildButtonsMenu()
        ],
      );
  }

  Widget _buildButtonsMenu() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          FlatButton(
              onPressed: (){
                setState(() {
                  _starColor = Colors.blue;
                  _endColor = Colors.cyan;
                });
                _selectedPage = 0;
                },
              color: _selectedPage == 0 ? Colors.white10 : Colors.transparent,
              child: Text('Sitios', style: TextStyle(color: Colors.white)
              )
          ),
          FlatButton(
              onPressed: (){
                setState(() {
                  _starColor = Colors.red;
                  _endColor = Colors.orange;
                });
                _selectedPage = 1;
              },
              color: _selectedPage == 1 ? Colors.white10 : Colors.transparent,
              child: Text('Eventos', style: TextStyle(color: Colors.white)
              )
          ),
          /*Flexible(
            child: FlatButton(
                onPressed: (){
                  setState(() {
                    _starColor = Colors.green;
                    _endColor = Colors.lightGreen;
                  });
                  _selectedPage = 2;
                },
                color: _selectedPage == 2 ? Colors.white10 : Colors.transparent,
                child: Text('Actividades', style: TextStyle(color: Colors.white)
                )
            ),
          ),*/
          FlatButton(
              onPressed: (){
                setState(() {
                  _starColor = Colors.green;
                  _endColor = Colors.lightGreen;
                });
                _selectedPage = 3;
              },
              color: _selectedPage == 3 ? Colors.white10 : Colors.transparent,
              child: Text('Historias', style: TextStyle(color: Colors.white)
              )
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
        width: _screenSize.width*0.8,
        height: _screenSize.height*0.06,
        margin: EdgeInsets.only(top: 50.0, right: 10.0),
        padding: EdgeInsets.only(left: 15.0, right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color.fromRGBO(249, 249, 249, 0.6)
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Quiero explorar',
            suffixIcon: Icon(Icons.search, color: Colors.white,),
          ),
          keyboardType: TextInputType.text,
          style: TextStyle(height: 1.3, fontSize: 19.5, color: Colors.white),
        ),
      ),
    );
  }

  _buildPrincipalContainer() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            color: Colors.white
        ),
        child: StreamBuilder<LocationState>(
          stream: locationBloc.locationStream,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data is LocationLoaded){

              _pages = [
                SitesPage(sitesOfLocationSelected: snapshot.data.location.sites),
                EventsPage(events: snapshot.data.location.events,),
                Container(),
                HistoriesPage(histories: snapshot.data.location.histories),
              ];

              switch(_selectedPage){
                case 0:
                  return _pages[_selectedPage];
                  break;
                case 1:
                  return _pages[_selectedPage];
                  break;
                case 3:
                  return _pages[_selectedPage];
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}