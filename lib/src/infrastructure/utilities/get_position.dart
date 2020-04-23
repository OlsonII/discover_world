
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionProvider{

  var _position;

  getPosition() async{
    _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(_position != null) return new CameraPosition(target: LatLng(_position.latitude, _position.longitude), zoom: 14.5);
  }

  getCoordinates() async {
    _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(_position != null) return LatLng(_position.latitude, _position.longitude);
  }
}