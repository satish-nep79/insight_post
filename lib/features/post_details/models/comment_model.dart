class CommentModel {
  static String get tableName => "Comment";
  static String get createQuery => '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      postId INTEGER,
      name TEXT,
      email TEXT,
      body TEXT
    )
  ''';

  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentModel({this.postId, this.id, this.name, this.email, this.body});

  CommentModel.fromJson(Map<String, dynamic> json) {
    postId = int.tryParse(json['postId'].toString());
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }

  static List<CommentModel> listFromJson(Object? listJson) => listJson is List
      ? List<CommentModel>.from(
          listJson.map(
            (json) => CommentModel.fromJson(json),
          ),
        )
      : [];
}
