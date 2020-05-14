
import 'position.dart';

class Event {
  String id;
  String name;
  String description;
  Position position;
  String initialDate;
  String endDate;
  String initialHour;
  String endHour;
  String image;

  Event({
    this.id,
    this.name,
    this.description,
    this.position,
    this.initialDate,
    this.endDate,
    this.initialHour,
    this.endHour,
    this.image
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    position: json['position'] != null ? Position.fromJson(json["position"]) : null,
    initialDate: json["initial_date"],
    endDate: json["end_date"],
    initialHour: json["initial_hour"],
    endHour: json["end_hour"],
    image: json["image"]
  );

}