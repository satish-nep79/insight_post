class PhotoModel {
  static String get tableName => "Photo";
  static String get createQuery => '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      albumId INTEGER,
      title TEXT,
      url TEXT,
      thumbnailUrl TEXT
    )
  ''';

  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }

  static List<PhotoModel> listFromJson(Object? listJson) => listJson is List
      ? List<PhotoModel>.from(
          listJson.map(
            (json) => PhotoModel.fromJson(json),
          ),
        )
      : [];
}
