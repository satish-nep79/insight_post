import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';
import 'package:insight_post/features/user_detail/model/album_model.dart';
import 'package:insight_post/features/user_detail/model/photo_model.dart';
import 'package:insight_post/features/user_detail/model/todo_model.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/utils/log_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static String dbName = "insight_post_db.db";
  static Database? _db;

  Future<Database> getDb() async {
    LogHelper.info(title: "Fetching DB");
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    LogHelper.info(title: "iniatialize db");
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/$dbName";
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(PostModel.createQuery);
    await db.execute(User.createQuery);
    await db.execute(CommentModel.createQuery);
    await db.execute(TodoModel.createQuery);
    await db.execute(AlbumModel.createQuery);
    await db.execute(PhotoModel.createQuery);
  }

  Future<List<PostModel>> getPosts() async {
    try {
      var results = await _db!.query(PostModel.tableName);
      return PostModel.listFromJson(results);
    } catch (e) {
      LogHelper.error(title: "Db Error Posts Fetch", message: e.toString());
      return [];
    }
  }

  Future<void> insertComments(List<CommentModel> comments) async {
    for (var comment in comments) {
      await insertComment(comment);
    }
  }

  Future<void> insertComment(CommentModel comment) async {
    await _db!.insert(CommentModel.tableName, comment.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertPhotos(List<PhotoModel> photos) async {
    for (var photo in photos) {
      await insertPhoto(photo);
    }
  }

  Future<void> insertPhoto(PhotoModel photo) async {
    await _db!.insert(PhotoModel.tableName, photo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertAlbums(List<AlbumModel> albums) async {
    for (var album in albums) {
      await insertAlbum(album);
    }
  }

  Future<void> insertAlbum(AlbumModel album) async {
    await _db!.insert(AlbumModel.tableName, album.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTodos(List<TodoModel> todos) async {
    for (var todo in todos) {
      await insertTodo(todo);
    }
  }

  Future<void> insertTodo(TodoModel todo) async {
    await _db!.insert(TodoModel.tableName, todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    try {
      var results = await _db!.query(User.tableName);
      return User.listFromDBJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Users Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<List<CommentModel>> getPostComments(num postId) async {
    try {
      var results = await _db!.query(CommentModel.tableName,
          where: "postId=?", whereArgs: ["$postId"]);
      return CommentModel.listFromJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Comments Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<List<PostModel>> getUserPosts(num userId) async {
    try {
      var results = await _db!.query(PostModel.tableName,
          where: "userId=?", whereArgs: ["$userId"]);
      return PostModel.listFromJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Posts Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<List<TodoModel>> getUserTodo(num userId) async {
    try {
      var results = await _db!.query(TodoModel.tableName,
          where: "userId=?", whereArgs: ["$userId"]);
      return TodoModel.listFromJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Posts Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<List<AlbumModel>> getUserAlbums(num userId) async {
    try {
      var results = await _db!.query(AlbumModel.tableName,
          where: "userId=?", whereArgs: ["$userId"]);
      return AlbumModel.listFromJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Posts Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }

  Future<List<PhotoModel>> getAlbumPhotoes(num albumId) async {
    try {
      var results = await _db!.query(PhotoModel.tableName,
          where: "albumId=?", whereArgs: ["$albumId"]);
      return PhotoModel.listFromJson(results);
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error Posts Fetch", message: e.toString(), stackTrace: s);
      return [];
    }
  }


  Future<User?> getUser({String? whereString, List<String>? args}) async {
    try {
      var results =
          await _db!.query(User.tableName, where: whereString, whereArgs: args);
      if (results.isEmpty) return null;
      LogHelper.info(title: "user data", message: results[0].toString());
      var user = User.fromDBJson(results[0]);
      return user;
    } catch (e, s) {
      LogHelper.error(
          title: "Db Error User Fetch", message: e.toString(), stackTrace: s);
      return null;
    }
  }

  Future<bool> userExists(int id) async {
    var user = await getUser(whereString: "id=?", args: ["$id"]);
    return user != null;
  }

  Future<void> insertUser(User user) async {
    bool exists = await userExists(user.id!);
    if (exists) {
      LogHelper.info(
          title: "User already exists", message: "User ID: ${user.id}");
      return;
    }
    try {
      await _db!.insert(User.tableName, user.toDbJson());
      LogHelper.info(title: "User Saved", message: "User ID: ${user.id}");
    } catch (e) {
      LogHelper.error(title: "DB Error: Save User", message: e.toString());
    }
  }

  Future<bool> postExists(int id) async {
    var result = await _db!.query(
      PostModel.tableName,
      where: "id = ?",
      whereArgs: [id.toString()],
    );
    return result.isNotEmpty;
  }

  Future<void> insertPosts(List<PostModel> posts) async {
    for (var post in posts) {
      await insertPost(post);
    }
  }

  Future<void> insertUsers(List<User> users) async {
    for (var user in users) {
      await insertUser(user);
    }
  }

  Future<void> insertPost(PostModel post) async {
    bool exists = await postExists(post.id!);
    if (exists) {
      LogHelper.info(
          title: "Post already exists", message: "Post ID: ${post.id}");
      return;
    }
    try {
      await _db!.insert(PostModel.tableName, post.toJson());
      LogHelper.info(title: "Post Saved", message: "Post ID: ${post.id}");
    } catch (e) {
      LogHelper.error(title: "DB Error: Save Post", message: e.toString());
    }
  }

  Future<PostModel?> getPost({String? whereString, List<String>? args}) async {
    try {
      var results = await _db!.query(
        PostModel.tableName,
        where: whereString,
        whereArgs: args,
      );
      if (results.isEmpty) return null;
      return PostModel.fromJson(results[0]);
    } catch (e) {
      LogHelper.error(title: "DB Error: Post Fetch", message: e.toString());
      return null;
    }
  }
}
