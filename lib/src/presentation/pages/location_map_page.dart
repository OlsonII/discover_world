import 'package:discover_world/src/aplication/bloc/maps_bloc.dart';
import 'package:discover_world/src/aplication/bloc/maps_event.dart';
import 'package:discover_world/src/aplication/bloc/maps_state.dart';
import 'package:discover_world/src/infrastructure/utilities/routes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapPage extends StatefulWidget {
  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {

  Size screenSize;
  GoogleMapController _controller;
  CameraPosition _position;
  LatLng _coordinates;
  int _markersIds = 0;
  MapType _mapType = MapType.normal;
  bool _myLocationEnabled = true;
  bool _myLocationButtonEnabled = false;

  final Set<Marker> _markers = Set();
  final Set<Polyline> _lines = Set();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mapsBloc.sendMapEvent.add(GetPosition());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(55, 157, 168, 1),
            elevation: 5.0,
          ),
          body: _buildMap()
      ),
    );
  }

  _changeMapMode(){
    getMapJsonFile("assets/silver_map.json").then(setMapStyle);
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

          _position = snapshot.data.position;
          _coordinates = snapshot.data.coordinates;

          return Container(
              child: GoogleMap(
                myLocationEnabled: _myLocationEnabled,
                myLocationButtonEnabled: _myLocationButtonEnabled,
                mapType: _mapType,
                initialCameraPosition: _position,
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
