class User{
  String userId;
  String password;
  User(this.userId, this.password);
  convertToMap(){
    Map<String, dynamic> map = {
      'userId': this.userId,
      'password': this.password,
    };
    return map;
  }
}