
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:flutter/cupertino.dart';

abstract class LocationState{}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState{}

class LocationLoaded extends LocationState{

  final Location location;

  LocationLoaded({@required this.location}) : assert(location != null);

  List<Object> get props => [location];
}

class LocationError extends LocationState{}