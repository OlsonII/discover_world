import 'package:discover_world/src/aplication/bloc/location_bloc.dart';
import 'package:discover_world/src/aplication/bloc/location_event.dart';
import 'package:discover_world/src/aplication/bloc/location_state.dart';
import 'package:discover_world/src/presentation/pages/events_page.dart';
import 'package:discover_world/src/presentation/pages/histories_page.dart';
import 'package:discover_world/src/presentation/pages/sites_page.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailLocationPage extends StatefulWidget {

  DetailLocationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailLocationPageState createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> with SingleTickerProviderStateMixin {

  Size _screenSize;
  bool _isCollapsed = false;
  Duration _animationDuration = Duration(milliseconds: 400);
  String locationSelected = 'Valledupar';
  List<Widget> _pages;
  int _selectedPage = 0;
  Color _starColor = Color.fromRGBO(55, 157, 168, 1);
  Color _endColor = Color.fromRGBO(99, 196, 207, 1);
  Color _searchBarItemsColor = Color.fromRGBO(55, 157, 168, 0.6);
  AnimationController _buttonMenuAnimationController;

  @override
  void initState() {
    super.initState();
    _buttonMenuAnimationController = AnimationController(duration: _animationDuration, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
//    locationSelected = ModalRoute.of(context).settings.arguments;
    locationBloc.sendLocationEvent.add(GetLocation(locationName: locationSelected));

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    return AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeIn,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  _starColor,
                  _endColor
                ],
                stops: [0.0, 0.95]
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
                    child: Text('Mapa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))),
                onPressed: () => Navigator.pushNamed(context, '/location_map'),
              ),
            ),
            Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.5,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Explorar otra', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))),
                onPressed: () => Navigator.pushReplacementNamed(context, '/search_location'),
              ),
            ),
            Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.5,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Salir', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))),
                onPressed: () => SystemNavigator.pop(),
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
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: _buttonMenuAnimationController,
                      color: Colors.white,
                      size: 27.0,
                    ), //Icon(Icons.menu, size: 27.0, color: Colors.white)
                ),
                onTap: (){
                  setState(() {
                    _isCollapsed = !_isCollapsed;
                    _isCollapsed ? _buttonMenuAnimationController.forward() : _buttonMenuAnimationController.reverse();
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                setState(() {
                  _starColor = Color.fromRGBO(55, 157, 168, 1);
                  _endColor = Color.fromRGBO(99, 196, 207, 1);
                  _searchBarItemsColor = Color.fromRGBO(55, 157, 168, 0.6);
                });
                _selectedPage = 0;
                },
              color: _selectedPage == 0 ? Colors.white : Colors.transparent,
              child: Text('Sitios', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: _selectedPage == 0 ? _starColor = Color.fromRGBO(55, 157, 168, 1) : Colors.white)
              )
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                setState(() {
                  _starColor = Color.fromRGBO(244, 100, 82, 1);
                  _endColor = Color.fromRGBO(254, 126, 110, 1);
                  _searchBarItemsColor = Color.fromRGBO(244, 100, 82, 0.6);
                });
                _selectedPage = 1;
              },
              color: _selectedPage == 1 ? Colors.white : Colors.transparent,
              child: Text('Eventos', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: _selectedPage == 1 ? _starColor = Color.fromRGBO(244, 100, 82, 1) : Colors.white)
              )
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
              onPressed: (){
                setState(() {
                  _starColor = Color.fromRGBO(113, 120, 211, 1);
                  _endColor = Color.fromRGBO(137, 143, 223, 1);
                  _searchBarItemsColor = Color.fromRGBO(113, 120, 211, 0.6);
                });
                _selectedPage = 2;
              },
              color: _selectedPage == 2 ? Colors.white : Colors.transparent,
              child: Text('Historias', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: _selectedPage == 2 ? _starColor = Color.fromRGBO(113, 120, 211, 1) : Colors.white)
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
        padding: EdgeInsets.only(left: 15.0, right: 3.0, top: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color.fromRGBO(255, 255, 255, 1)
        ),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Quiero explorar',
              hintStyle: TextStyle(fontFamily: 'ProductSans', fontWeight: FontWeight.bold, color: _searchBarItemsColor),
              suffixIcon: FaIcon(FontAwesomeIcons.search, color: _starColor, size: 25.0)
          ),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(height: 1.3, fontWeight: FontWeight.bold, fontSize: 19.5, color: _searchBarItemsColor),
          enabled: !_isCollapsed ? true : false,
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
                HistoriesPage(histories: snapshot.data.location.histories),
              ];

              switch(_selectedPage){
                case 0:
                  return _pages[_selectedPage];
                  break;
                case 1:
                  return _pages[_selectedPage];
                  break;
                case 2:
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