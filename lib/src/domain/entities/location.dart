import 'dart:convert';
import 'event.dart';
import 'history.dart';
import 'position.dart';
import 'site.dart';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

class Location {
  String id;
  String name;
  String description;
  Position position;
  String department;
  String type;
  List<Event> events;
  List<History> histories;
  List<Site> sites;

  Location({
    this.id,
    this.name,
    this.description,
    this.position,
    this.department,
    this.type,
    this.events,
    this.histories,
    this.sites,
  });

  factory Location.fromJson(Map<String, dynamic> json) {

    List<Site> sitesList;
    List<Event> eventList;
    List<History> historiesList;

    var list = json['sites'] as List;
    list != null ? sitesList = list.map((site) => Site.fromJson(new Map<String, dynamic>.from(site))).toList() : [];

    list = json['events'] as List;
    list != null ? eventList = list.map((event) => Event.fromJson(new Map<String, dynamic>.from(event))).toList() : [];

    list = json['histories'] as List;
    list != null ? historiesList = list.map((history) => History.fromJson(new Map<String, dynamic>.from(history))).toList() : [];

    return Location(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      position: json['position'] != null ? Position.fromJson(json["position"]) : null,
      department: json["department"],
      type: json["type"],
      events: eventList,
      histories: historiesList,
      sites: sitesList,
    );
  }
}