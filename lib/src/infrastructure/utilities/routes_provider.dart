import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RoutesProviders{

  LatLng _initialCoordinate;
  LatLng _finalCoordinates;
  List<Point> _points;


  RoutesProviders(LatLng initialCoordinate, LatLng finalCoordinate){
    _initialCoordinate = initialCoordinate;
    _finalCoordinates = finalCoordinate;
  }

  //TODO: QUEDAMOS POR ACA
  Future<List<Point>> getPoints() async {
    _points = new List();
    final response = await http.get('https://maps.googleapis.com/maps/api/directions/json?origin=${_initialCoordinate.latitude}, ${_initialCoordinate.longitude}&destination=${_finalCoordinates.latitude}, ${_finalCoordinates.longitude}&key=AIzaSyCMilZYFIj639EFETXXB9ishMktb4JGKzU');
    final decodedResponse = jsonDecode(response.body);
    decodedResponse['routes'][0]['legs'][0]['steps'].forEach((point){
      final startPoint = new LatLng(point['start_location']['lat'], point['start_location']['lng']);
      final endPoint = new LatLng(point['end_location']['lat'], point['end_location']['lng']);
      final distance = point['distance']['value'];
      final duration = point['duration']['value'];
      _points.add(new Point(startPoint, endPoint, distance, duration));
    });
    return _points;
  }

}

class Point{

  LatLng startPoint;
  LatLng endPoint;
  int distanceMeters;
  int durationSec;

  Point(LatLng start, LatLng end, int distance, int duration){
    startPoint = start;
    endPoint = end;
  }
}