import 'package:discover_world/src/aplication/bloc/location_bloc.dart';
import 'package:discover_world/src/aplication/bloc/location_event.dart';
import 'package:discover_world/src/aplication/bloc/location_state.dart';
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/infrastructure/utilities/search_system.dart';
import 'package:discover_world/src/presentation/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchLocationPage extends StatefulWidget {

  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {

  Size _screenSize;
  Color _principalColor = ThemeColors.principalColor;
  String _locationSelected;
  List<Location> _locations;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    locationBloc.sendLocationEvent.add(GetLocations());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: _principalColor,
            /*gradient: LinearGradient(
                colors: [
                  _principalColor,
                  _secondColor
                ],
                stops: [0.0, 0.9]
            )*/
        ),
        child: Column(
          children: <Widget>[
            _buildSearchBar(),
            SizedBox(height: _screenSize.height*0.04,),
            _buildPrincipalContainer(),
//            SizedBox(height: _screenSize.height*0.02,),
            /*_buildExploreButton(context),
            SizedBox(height: _screenSize.height*0.02,),*/
          ],
        ),
      ),
    );
  }

  Container _buildExploreButton(BuildContext context) {
    return Container(
            width: _screenSize.width*0.5,
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: (){
                  _locationSelected != null ?
                  Navigator.pushReplacementNamed(context, '/detail_info_location', arguments: _locationSelected)
                  // ignore: unnecessary_statements
                  : null;
                },
                color: Colors.white,
                child: Text('Explorar', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: ThemeColors.textColors)
                )
            ),
          );
  }

  Expanded _buildPrincipalContainer() {
    return Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
                color: ThemeColors.backgroundColor
              ),
              child: StreamBuilder(
                stream: locationBloc.locationStream,
                builder: (context, snapshot){
                  if(snapshot.data is LocationsLoaded){
                    _locations = snapshot.data.locations;
                    return ListView.builder(
                      itemCount: _locations.length,
                        itemBuilder: (context, item) => _buildItem(context, _locations[item])
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Container(
          width: _screenSize.width*0.7,
          height: _screenSize.height*0.06,
          margin: EdgeInsets.only(top: 50.0, right: 7.0, left: 17.0),
          padding: EdgeInsets.only(left: 15.0, right: 3.0, top: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: ThemeColors.backgroundColor
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Quiero explorar',
                hintStyle: TextStyle(fontFamily: 'ProductSans', fontWeight: FontWeight.bold, color: ThemeColors.textColors),
//                suffixIcon: FaIcon(FontAwesomeIcons.search, color: _principalColor)
            ),
            onChanged: (value){
              _locationSelected = value;
            },
            textCapitalization: TextCapitalization.words,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            style: TextStyle(height: 1.3, fontWeight: FontWeight.bold, fontSize: 19.5, color: _principalColor),
          ),
        ),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.only(top: 50.0, right: 10.0),
          child: FlatButton(
              onPressed: (){
                if(_validateStringToSearch(_locationSelected)){
                  _locationSelected != null ?
                  Navigator.pushReplacementNamed(context, '/detail_info_location', arguments: _locationSelected)
                  // ignore: unnecessary_statements
                      : null;
                }else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Error', style: TextStyle(fontWeight: FontWeight.bold),),
                          content: Text('No tenemos localizacion registrada con el nombre ${_locationSelected}'),
                          actions: [
                            FlatButton(
                              child: Text('Cerrar'),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        );
                      }
                  );
                }
              },
              child: FaIcon(FontAwesomeIcons.search, color: ThemeColors.iconsColors)
          ),
        )
      ],
    );
  }

  _validateStringToSearch(String name){
    _locations.forEach((element) {
      if(element.name == name)
        return true;
    });
    return false;
  }

  _buildItem(BuildContext context, item) {
    return ListTile(
      title: Text('${item.name} - ${item.department} (${item.type})', style: TextStyle(color: ThemeColors.principalColor, fontWeight: FontWeight.bold)),
      subtitle: Text(item.description),
      leading: Container(width: _screenSize.width*0.22, child: Image(image: NetworkImage(item.image))),
      onTap: (){
        Navigator.pushReplacementNamed(context, '/detail_info_location', arguments: item.name);
      },
    );
  }

  _search(String name){
    var searcher = new SearchSystem(null, _locations);
    return searcher.searchLocationByName(name);
  }
}
