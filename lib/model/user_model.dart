class User {
  String? name;
  String? email;
  String? password;
  String? role;

  User({this.name, required this.email, required this.password, this.role});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
