
import 'activity.dart';
import 'position.dart';

class Site {
  String id;
  String name;
  String description;
  Position position;
  String direction;
  String type;
  String image;
  List<Activity> activities;

  Site({
    this.id,
    this.name,
    this.description,
    this.position,
    this.direction,
    this.type,
    this.image,
    this.activities,
  });

  factory Site.fromJson(Map<String, dynamic> json) {

    List<Activity> activitiesList;
    List<dynamic> positionList;

    var list = json['activities'] as List;
    list != null ? activitiesList = list.map((activity) => Activity.fromJson(new Map<String, dynamic>.from(activity))).toList() : [];

    var pos = json['position'] != null ? new Position(latitude: json['position']['latitude'], longitude: json['position']['longitude']) : null;

    return Site(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      position: pos,
      direction: json["direction"],
      type: json["type"],
      image: json["image"],
      activities: activitiesList,
    );
  }
}