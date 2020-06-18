
class History {
  String id;
  String name;
  String content;
  String type;
  String image;

  History({
    this.id,
    this.name,
    this.content,
    this.type,
    this.image
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    name: json["name"],
    content: json["content"],
    type: json["type"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "content": content,
    "type": type,
  };
}