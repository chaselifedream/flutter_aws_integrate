
/// User data retrieved from backend
class UserModel {
  String username;
  Map<String, String> userAttributes;

  void init(String username, Map<String, String> userAttributes) {
    this.username = username;
    this.userAttributes = userAttributes;
  }

  void changeUsername() {
    this.username = 'A new name';
  }
}
