import 'package:discover_world/src/domain/entities/event.dart';
import 'package:discover_world/src/domain/entities/history.dart';
import 'package:discover_world/src/domain/entities/location.dart';
import 'package:discover_world/src/domain/entities/site.dart';

class SearchSystem{

  Location location;
  List<Location> locations;


  SearchSystem(this.location, this.locations);

  List<Site> searchSiteByName(String name){
    List<Site> listResult = new List();
    location.sites.forEach((element) {
      if(element.name == name)
        listResult.add(element);
    });
    return listResult;
  }

  List<Site> searchSiteByActivity(String activityName){
    List<Site> listResult = new List();
    location.sites.forEach((element) {
      if(element.activities != null)
        element.activities.forEach((activity) {
          if(activity.name == activityName)
            listResult.add(element);
        });
    });
    return listResult;
  }

  List<Site> searchSiteByType(String type){
    List<Site> listResult = new List();
    location.sites.forEach((element) {
      if(element.type == type)
        listResult.add(element);
    });
    return listResult;
  }

  searchEventByName(String name){
    List<Event> listResult = new List();
    location.events.forEach((element) {
      if(element.name == name)
        listResult.add(element);
    });
    return listResult;
  }

  searchHistoryByName(String name){
    List<History> listResult = new List();
    location.histories.forEach((element) {
      if(element.name == name)
        listResult.add(element);
    });
    return listResult;
  }

  searchLocationByName(String name){
    List<Location> listResult = new List();
    locations.forEach((element) {
      if(element.name == name)
        listResult.add(element);
    });
    return listResult;
  }

}