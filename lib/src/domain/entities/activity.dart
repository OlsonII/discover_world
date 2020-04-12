class Activity {
  String id;
  String name;
  String description;

  Activity({
    this.id,
    this.name,
    this.description,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
  };
}