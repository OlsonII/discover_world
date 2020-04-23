import 'package:discover_world/src/infrastructure/utilities/routes_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsState{}

class PositionLoaded extends MapsState {

  final CameraPosition position;
  final LatLng coordinates;

  PositionLoaded({this.position, this.coordinates}) : assert(position != null && coordinates != null);

  Object get props => position;
  Object get coord => coordinates;
}

class RouteLoaded extends MapsState{
  final List<Point> points;

  RouteLoaded({this.points}) : assert(points != null);

  Object get props => points;
}