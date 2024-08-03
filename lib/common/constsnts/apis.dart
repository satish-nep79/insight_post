class Apis {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  static String get getPostsUrl => "$baseUrl/posts";
  static String getPostDetailUrl(int postId) => "$baseUrl/posts/$postId";
  static String getPostCommentsUrl(int postId) => "$baseUrl/posts/$postId/comments";
  static String getUserPostsUrl(int userId) => "$baseUrl/users/$userId/posts";
  static String getUsersUrl(int userId) => "$baseUrl/users";
  static String getUserTodosUrl(int userId) => "$baseUrl/users/$userId/todos";
  static String getUserAlbumsUrl(int userId) => "$baseUrl/users/$userId/albums";
  static String getAlbumPhotoesUrl(int albumId) =>
      "$baseUrl/albums/$albumId/photos";
}
