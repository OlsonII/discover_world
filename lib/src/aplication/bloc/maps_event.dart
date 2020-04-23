
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsEvent extends Equatable{
  const  MapsEvent();
}

class GetPosition extends MapsEvent {

  final CameraPosition cameraPosition;

  const GetPosition({this.cameraPosition});

  @override
  List<Object> get props => [cameraPosition];

}

class GetRoute extends MapsEvent {

  final LatLng startRoute;
  final LatLng endRoute;

  const GetRoute({@required this.startRoute, @required this.endRoute}) : assert( startRoute != null && endRoute != null);

  @override
  List<Object> get props => [startRoute, endRoute];

}