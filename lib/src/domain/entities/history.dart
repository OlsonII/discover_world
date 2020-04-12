
class History {
  String id;
  String name;
  String content;
  String type;

  History({
    this.id,
    this.name,
    this.content,
    this.type,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    name: json["name"],
    content: json["content"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "content": content,
    "type": type,
  };
}