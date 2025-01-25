abstract class ICacheStorage {
  Future<String?> getString(String endpoint);

  void setString(String endpoint, String body);

}