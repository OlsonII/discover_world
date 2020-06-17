import 'package:discover_world/src/aplication/bloc/maps_bloc.dart';
import 'package:discover_world/src/aplication/bloc/maps_event.dart';
import 'package:discover_world/src/aplication/bloc/maps_state.dart';
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/domain/entities/position.dart';
import 'package:discover_world/src/infrastructure/utilities/routes_provider.dart';
import 'package:discover_world/src/presentation/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapPage extends StatefulWidget {

  /*CameraPosition cameraPosition;


  LocationMapPage(LatLng position){
    cameraPosition = new CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14.5);
  }*/

  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {

  Size screenSize;
  GoogleMapController _controller;
  CameraPosition _cameraPosition;
  LatLng _coordinates;
  int _markersIds = 0;
  MapType _mapType = MapType.normal;
  bool _myLocationEnabled = true;
  bool _myLocationButtonEnabled = false;
  Location _location;

  final Set<Marker> _markers = Set();
  final Set<Polyline> _lines = Set();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    _location = arguments["Location"];
    _mapPosition(_location.position);

    screenSize = MediaQuery.of(context).size;
    mapsBloc.sendMapEvent.add(GetPosition());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.principalColor,
            elevation: 5.0,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: ThemeColors.iconsColors), onPressed: () => Navigator.of(context).pop(),)
          ),
          body: _buildMap()
      ),
    );
  }

  _mapPosition(Position pos){
    _cameraPosition = new CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 14.5);
    _coordinates = new LatLng(pos.latitude, pos.longitude);
    _initMarkers();
  }

  _changeMapMode(){
    getMapJsonFile("assets/dark_map.json").then(setMapStyle);
  }

  Future<String> getMapJsonFile(String path) async{
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle){
    _controller.setMapStyle(mapStyle);
  }

  Widget _buildMap() {
    return StreamBuilder(
      stream: mapsBloc.mapsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Container(color: Colors.black87, child: Center(child: CircularProgressIndicator()));
        }

        if(snapshot.data is PositionLoaded){

          _coordinates = snapshot.data.coordinates;

          return Container(
              child: GoogleMap(
                myLocationEnabled: _myLocationEnabled,
                myLocationButtonEnabled: _myLocationButtonEnabled,
                mapType: _mapType,
                initialCameraPosition: _cameraPosition,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) => _onMapCreated(controller),
                onLongPress: (position) => _addMarker(position),
                polylines: _lines,
              )
          );
        }else if(snapshot.data is RouteLoaded){
          _buildRoute(snapshot.data.points);
          mapsBloc.sendMapEvent.add(GetPosition());
        }
        return Container();
      },
    );
  }

  _onMapCreated(GoogleMapController controller){
    _controller = controller;
    _changeMapMode();
  }

  _initMarkers(){
    _location.sites.forEach((element) {
      _markers.add(Marker(
        markerId: MarkerId(_markersIds.toString()),
        position: new LatLng(element.position.latitude, element.position.longitude),

      ));
      _markersIds++;
    });
  }

  _addMarker(LatLng position){
    mapsBloc.sendMapEvent.add(GetRoute(startRoute: _coordinates, endRoute: position));
    _markers.add(Marker(
      markerId: MarkerId(_markersIds.toString()),
      position: position,
    ));
    _markersIds++;
    /*setState(() {

    });*/
  }

  _buildRoute(List<Point> points) {
    points.forEach((p) {
      _lines.add(
          Polyline(
              polylineId: PolylineId('$_markersIds'),
              color: Colors.red,
              width: 4,
              points: [
                p.startPoint,
                p.endPoint
              ],
              visible: true
          )
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
