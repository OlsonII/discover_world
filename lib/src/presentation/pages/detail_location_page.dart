import 'package:discover_world/src/aplication/bloc/location_bloc.dart';
import 'package:discover_world/src/aplication/bloc/location_event.dart';
import 'package:discover_world/src/aplication/bloc/location_state.dart';
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/domain/entities/site.dart';
import 'package:discover_world/src/infrastructure/utilities/search_system.dart';
import 'package:discover_world/src/presentation/colors/colors.dart';
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
  Duration _animationDuration = Duration(milliseconds: 300);
  String _nameLocationSelected = 'Valledupar';
  Location _location;
  List<Widget> _pages;
  int _selectedPage = 0;
  Color _startColor = ThemeColors.sitesColor;
  Color _searchBarItemsColor = Color.fromRGBO(55, 157, 168, 0.6);
  AnimationController _buttonMenuAnimationController;
  String _stringToSearch = "";

  @override
  void initState() {
    super.initState();
    _buttonMenuAnimationController = AnimationController(duration: _animationDuration, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;
    _nameLocationSelected = ModalRoute.of(context).settings.arguments;
    locationBloc.sendLocationEvent.add(GetLocation(locationName: _nameLocationSelected));

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
        color: _startColor,
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
                onPressed: () => Navigator.pushNamed(context, '/location_map', arguments: {"Location": _location}),
              ),
            ),
            /*Container(
              height: _screenSize.height*0.04,
              width: _screenSize.width*0.8,
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Centros de transporte', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))),
                    onPressed: (){},
//                onPressed: () => Navigator.pushNamed(context, '/location_map'),
              ),
            ),*/
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
                    child: Text('Mas informacion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white))),
                onPressed: () => Navigator.pushReplacementNamed(context, '/detail_info_location', arguments: _nameLocationSelected),
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
              Container(
                margin: EdgeInsets.only(top: 50.0, right: 10.0),
                width: _screenSize.width*0.15,
                child: FlatButton(
                    onPressed: (){
                      setState(() {
                        _searchSystem();
                      });
                    },
                    child: FaIcon(FontAwesomeIcons.search, color: Colors.white)
                ),
              )
            ],
          ),
          _buildButtonsMenu()
        ],
      );
  }

  Widget _buildButtonsMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.05,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                setState(() {
                  _startColor = ThemeColors.sitesColor;
                  _searchBarItemsColor = Color.fromRGBO(55, 157, 168, 0.6);
                });
                _selectedPage = 0;
                },
              color: _selectedPage == 0 ? Colors.white : Colors.transparent,
              child: Text('Sitios',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: _selectedPage == 0 ? _startColor : Colors.white)
              )
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                setState(() {
                  _startColor = ThemeColors.culturalsColor;
                  _searchBarItemsColor = Color.fromRGBO(55, 157, 168, 0.6);
                });
                _selectedPage = 1;
              },
              color: _selectedPage == 1 ? Colors.white : Colors.transparent,
              child: Text('Culturales',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: _selectedPage == 1 ? _startColor : Colors.white
                  )
              )
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                setState(() {
                  _startColor = ThemeColors.eventsColor;
                  _searchBarItemsColor = Color.fromRGBO(244, 100, 82, 0.6);
                });
                _selectedPage = 2;
              },
              color: _selectedPage == 2 ? Colors.white : Colors.transparent,
              child: Text('Eventos',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: _selectedPage == 2 ? _startColor : Colors.white)
              )
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
              onPressed: (){
                setState(() {
                  _startColor = ThemeColors.historiesColor;
                  _searchBarItemsColor = Color.fromRGBO(113, 120, 211, 0.6);
                });
                _selectedPage = 3;
              },
              color: _selectedPage == 3 ? Colors.white : Colors.transparent,
              child: Text('Historias',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight:
                      FontWeight.bold,
                      color: _selectedPage == 3 ? _startColor : Colors.white
                  )
              )
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
//        width: _screenSize.width*0.8,
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
              hintStyle: TextStyle(fontFamily: 'ProductSans', fontWeight: FontWeight.bold, color: _startColor),
//              suffixIcon: FaIcon(FontAwesomeIcons.search, color: _starColor, size: 25.0)
          ),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(height: 1.3, fontWeight: FontWeight.bold, fontSize: 19.5, color: _searchBarItemsColor),
          enabled: !_isCollapsed ? true : false,
          onChanged: (value){
            if(value == "")
              setState(() {
                _pages = null;
              });
            _stringToSearch = value;
          },
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
              _location = snapshot.data.location;
              List<Site> sites = new List();
              List<Site> cultural = new List();
              snapshot.data.location.sites.forEach((site){
                site.type == 'Centro Cultural' ? cultural.add(site) : sites.add(site);
              });

              if(_pages == null){
                _pages = [
                  SitesPage(sitesOfLocationSelected: sites == null ? [] : sites, location: _location),
                  SitesPage(sitesOfLocationSelected: cultural == null ? [] : cultural),
                  EventsPage(events: snapshot.data.location.events == null ? [] : snapshot.data.location.events,),
                  HistoriesPage(histories: snapshot.data.location.histories == null ? [] : snapshot.data.location.histories),
                ];
              }

              if(_isCollapsed) return Container();

              return _pages[_selectedPage];
            }
            return Container();
          },
        ),
      ),
    );
  }

  _searchSystem(){
    if(_stringToSearch == ""){
      setState(() {
        _pages = null;
      });
    }else{
      var searcher = new SearchSystem(_location, null);
      if(_pages[_selectedPage] is SitesPage){
        var resultByName = searcher.searchSiteByName(_stringToSearch);
        var resultByActivity = searcher.searchSiteByActivity(_stringToSearch);
        var resultByType = searcher.searchSiteByType(_stringToSearch);
        if(resultByName.length > 0){
          _pages[_selectedPage] = SitesPage(sitesOfLocationSelected: resultByName, location: _location);
        }else if(resultByActivity.length > 0){
          _pages[_selectedPage] = SitesPage(sitesOfLocationSelected: resultByActivity, location: _location);
        }else if(resultByType.length > 0){
          _pages[_selectedPage] = SitesPage(sitesOfLocationSelected: resultByType, location: _location);
        }
      }else if(_pages[_selectedPage] is EventsPage){
        var resultByName = searcher.searchEventByName(_stringToSearch);
        if(resultByName.length > 0){
          _pages[_selectedPage] = EventsPage(events: resultByName);
        }
      }else if(_pages[_selectedPage] is HistoriesPage){
        var resultByName = searcher.searchHistoryByName(_stringToSearch);
        if(resultByName.length > 0){
          _pages[_selectedPage] = HistoriesPage(histories: resultByName);
        }
      }
    }
  }


  @override
  void dispose() {
//    locationBloc.dispose();
    super.dispose();
  }
}