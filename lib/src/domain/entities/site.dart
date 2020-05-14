
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

    var list = json['activities'] as List;
    list != null ? activitiesList = list.map((activity) => Activity.fromJson(new Map<String, dynamic>.from(activity))).toList() : [];

    return Site(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      position: json['position'] != null ?  Position.fromJson(json["position"]) : null,
      direction: json["direction"],
      type: json["type"],
      image: json["image"],
      activities: activitiesList,
    );
  }
}