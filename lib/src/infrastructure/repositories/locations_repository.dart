
import 'dart:convert';

import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/infrastructure/contracts/i_locations_repository.dart';
import 'package:firebase_database/firebase_database.dart';


class LocationsRepository implements ILocationsRepository {


  static final db = FirebaseDatabase.instance.reference();
  static final locationsDocument = db.child('locations');

  LocationsRepository(){
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    locationsDocument.keepSynced(true);
  }

  @override
  getLocation(String locationName) async {
    Location location;

    await locationsDocument.child('${locationName}').once().then((DataSnapshot snapshot){
      var locationData = new Map<String, dynamic>.from(snapshot.value);
      location = new Location.fromJson(locationData);
    }).catchError((onError){
      print('Error: ${onError}');
    });

    return location;
  }
}