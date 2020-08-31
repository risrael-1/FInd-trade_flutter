class User {
  final String username;
  final String password;
  final String ville;
  final String email;
  final String status_user;
  final String phone;
  final String token;
  final String error;


  User(this.username, this.password, this.ville,this.email, this.status_user ,this.phone, this.token, this.error) ;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json["username"],
        json["password"],
        json["email"],
        json["ville"],
        json["status_user"],
        json["phone"],
        json['token'],
        json['error']
    );
  }
}