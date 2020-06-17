import 'package:discover_world/src/aplication/bloc/location_bloc.dart';
import 'package:discover_world/src/aplication/bloc/location_event.dart';
import 'package:discover_world/src/aplication/bloc/location_state.dart';
import 'package:discover_world/src/presentation/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailInfoLocationPage extends StatelessWidget {

  Size _screenSize;
  String _locationSelected = 'Valledupar';

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _locationSelected = ModalRoute.of(context).settings.arguments;
    locationBloc.sendLocationEvent.add(GetLocation(locationName: _locationSelected));
    return StreamBuilder<Object>(
      stream: locationBloc.locationStream,
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.data is LocationLoaded){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ThemeColors.principalColor,
              leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: ThemeColors.iconsColors), onPressed: () => Navigator.pushReplacementNamed(context, '/search_location')),
              title: Text('${snapshot.data.location.name}', style: TextStyle(fontWeight: FontWeight.bold),),
              actions: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.mapMarkedAlt, color: ThemeColors.iconsColors),
                    onPressed: () => Navigator.pushNamed(context, '/location_map', arguments: {"Location": snapshot.data.location}),
                )
              ],
            ),
            body: Container(
              color: ThemeColors.backgroundColor,
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Container(
                    padding: EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: ThemeColors.principalColor,),
                      onPressed: () => Navigator.pushReplacementNamed(context, '/search_location'),
                    ),
                  ),*/
                  Container(
                      height: _screenSize.height*0.4,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data.location.image),
//                                colorFilter: new ColorFilter.mode(Color.fromRGBO(244, 100, 82, 0.5), BlendMode.dstATop),
                              fit: BoxFit.cover
                          ),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.principalColor,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                    child: Text('Descripcion', style: TextStyle(fontSize: 22.0, color: ThemeColors.principalColor, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0, right: 12.0),
                    child: Text(snapshot.data.location.description, style: TextStyle(color: ThemeColors.principalColor, fontSize: 17.0),),
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildCardInfo(snapshot.data.location.sites == null ? 0 : snapshot.data.location.sites.length, 'Sitios'),
                      SizedBox(width: _screenSize.width*0.02,),
                      _buildCardInfo(snapshot.data.location.histories == null ? 0 : snapshot.data.location.histories.length, 'Historias'),
                      SizedBox(width: _screenSize.width*0.02),
                      _buildCardInfo(snapshot.data.location.events == null ? 0 : snapshot.data.location.events.length, 'Eventos'),
                    ],
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: Container(
                      width: _screenSize.width*0.5,
                      child: FlatButton(
                          color: ThemeColors.principalColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/details_location', arguments: _locationSelected),
                          child: Text('Explorar', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(55, 157, 168, 1))
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: _screenSize.height*0.02,)
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());

      }
    );
  }

  Container _buildCardInfo(data, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 7.0),
      decoration: BoxDecoration(
        color: ThemeColors.backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.principalColor,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text('${data}', style: TextStyle(fontSize: 17.0),),
          Text('$title', style: TextStyle(fontSize: 15.0),)
        ],
      ),
    );
  }
}
