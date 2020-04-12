
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LocationEvent extends Equatable{
  const LocationEvent();
}

//TODO: AUN NO ES SEGURA SU IMPLEMENTACION
class GetLocations extends LocationEvent{
  final List<Location> locations;

  const GetLocations({@required this.locations}) : assert(locations != null);

  @override
  List<Object> get props => [locations];
}

class GetLocation extends LocationEvent{
  final String locationName;

  const GetLocation({@required this.locationName}) : assert(locationName != null);

  @override
  List<Object> get props => [locationName];
}