class User{
  String userID,imageURL;
  int numberOfLogin;

  User.fromJSON(dynamic json){
    this.userID = json["userID"];
    this.imageURL = json["imageURL"];
    this.numberOfLogin = json["numberOfLogin"];
  }

}