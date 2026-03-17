class TrailerResultsModel {
  String name , key , type;
  DateTime publishedAt;

  TrailerResultsModel ({
    required this.name,
    required this.key,
    required this.type,
    required this.publishedAt,
  });

  factory TrailerResultsModel.fromJson(Map<String, dynamic> json){
    return TrailerResultsModel(
      name: json["name"],
      key: json["key"],
      type: json["type"],
      publishedAt: DateTime.parse(json["published_at"]),
    );
  }
}