class PostModel {
  static String get tableName => "PostModel";
  static String get createQuery => """
CREATE TABLE $tableName (
    userId INTEGER,
    id INTEGER PRIMARY KEY,
    title TEXT,
    body TEXT
);
""";

  int? userId;
  int? id;
  String? title;
  String? body;

  PostModel({this.userId, this.id, this.title, this.body});

  PostModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  static List<PostModel> listFromJson(Object? listJson) => listJson is List
      ? List<PostModel>.from(
          listJson.map(
            (json) => PostModel.fromJson(json),
          ),
        )
      : [];

  static List<dynamic> get dummyData => <Map<String, dynamic>>[
        {
          "userId": 2,
          "id": 11,
          "title": "et ea vero quia laudantium autem",
          "body":
              "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi"
        },
        {
          "userId": 2,
          "id": 12,
          "title": "in quibusdam tempore odit est dolorem",
          "body":
              "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio"
        },
        {
          "userId": 2,
          "id": 13,
          "title": "dolorum ut in voluptas mollitia et saepe quo animi",
          "body":
              "aut dicta possimus sint mollitia voluptas commodi quo doloremque\niste corrupti reiciendis voluptatem eius rerum\nsit cumque quod eligendi laborum minima\nperferendis recusandae assumenda consectetur porro architecto ipsum ipsam"
        },
        {
          "userId": 2,
          "id": 14,
          "title": "voluptatem eligendi optio",
          "body":
              "fuga et accusamus dolorum perferendis illo voluptas\nnon doloremque neque facere\nad qui dolorum molestiae beatae\nsed aut voluptas totam sit illum"
        },
        {
          "userId": 2,
          "id": 15,
          "title": "eveniet quod temporibus",
          "body":
              "reprehenderit quos placeat\nvelit minima officia dolores impedit repudiandae molestiae nam\nvoluptas recusandae quis delectus\nofficiis harum fugiat vitae"
        },
        {
          "userId": 2,
          "id": 16,
          "title":
              "sint suscipit perspiciatis velit dolorum rerum ipsa laboriosam odio",
          "body":
              "suscipit nam nisi quo aperiam aut\nasperiores eos fugit maiores voluptatibus quia\nvoluptatem quis ullam qui in alias quia est\nconsequatur magni mollitia accusamus ea nisi voluptate dicta"
        },
        {
          "userId": 2,
          "id": 17,
          "title": "fugit voluptas sed molestias voluptatem provident",
          "body":
              "eos voluptas et aut odit natus earum\naspernatur fuga molestiae ullam\ndeserunt ratione qui eos\nqui nihil ratione nemo velit ut aut id quo"
        },
        {
          "userId": 2,
          "id": 18,
          "title": "voluptate et itaque vero tempora molestiae",
          "body":
              "eveniet quo quis\nlaborum totam consequatur non dolor\nut et est repudiandae\nest voluptatem vel debitis et magnam"
        },
        {
          "userId": 2,
          "id": 19,
          "title": "adipisci placeat illum aut reiciendis qui",
          "body":
              "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
        },
        {
          "userId": 2,
          "id": 20,
          "title": "doloribus ad provident suscipit at",
          "body":
              "qui consequuntur ducimus possimus quisquam amet similique\nsuscipit porro ipsam amet\neos veritatis officiis exercitationem vel fugit aut necessitatibus totam\nomnis rerum consequatur expedita quidem cumque explicabo"
        }
      ];
}
