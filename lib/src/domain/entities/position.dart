
class Position {

  double latitude;
  double longitude;

  Position({
    this.latitude,
    this.longitude,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}