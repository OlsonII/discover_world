

import 'dart:async';
import 'package:discover_world/src/infrastructure/repositories/locations_repository.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc {

  final _repository = new LocationsRepository();

  StreamController<LocationEvent> _locationInput = StreamController();
  StreamController<LocationState> _locationOutput = StreamController.broadcast();

  Stream<LocationState> get locationStream => _locationOutput.stream;
  StreamSink<LocationEvent> get sendLocationEvent => _locationInput.sink;

  LocationBloc(){
    _locationInput.stream.listen(_onEvent);
  }

  void _onEvent(LocationEvent event) async {
    if(event is GetLocation){
      final location = await _repository.getLocation(event.locationName);
      _locationOutput.add(LocationLoaded(location: location));
    }
  }

  void dispose(){
    _locationInput.close();
    _locationOutput.close();
  }

}

final locationBloc = LocationBloc();