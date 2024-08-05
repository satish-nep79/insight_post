class TodoModel {
  static String get tableName => "Todo";
  static String get createQuery => '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      userId INTEGER,
      title TEXT,
      completed INTEGER
    )
  ''';

  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodoModel({this.userId, this.id, this.title, this.completed});

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }

  static List<TodoModel> listFromJson(Object? listJson) => listJson is List
      ? List<TodoModel>.from(
          listJson.map(
            (json) => TodoModel.fromJson(json),
          ),
        )
      : [];
}
