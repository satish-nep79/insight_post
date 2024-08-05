class AlbumModel {
  static String get tableName => "Album";
  static String get createQuery => '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      userId INTEGER,
      title TEXT
    )
  ''';

  int? userId;
  int? id;
  String? title;

  AlbumModel({this.userId, this.id, this.title});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }

  static List<AlbumModel> listFromJson(Object? listJson) => listJson is List
      ? List<AlbumModel>.from(
          listJson.map(
            (json) => AlbumModel.fromJson(json),
          ),
        )
      : [];
}
