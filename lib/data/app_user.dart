class AppUser {
  AppUser({
    // required this.userId,
    required this.username,
    required this.firstname,
    required this.othernames,
    required this.password,
  });
  late final int userId;
  late final String username;
  late final String? firstname;
  late final String? othernames;
  late final String password;
  late final String token;


  AppUser.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    username = json['username'];
    username = json['firstname'];
    username = json['othernames'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['username'] = username;
    _data['firstname'] = firstname;
    _data['othernames'] = othernames;
    _data['password'] = password;
    _data['token'] = token;

    return _data;
  }
}