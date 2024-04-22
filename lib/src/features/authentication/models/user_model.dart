class User {
  final int? user_id;
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password, this.user_id});

  factory User.fromJson(Map<String, dynamic> json) => User(
    user_id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id' : user_id,
    'name' : name,
    'email' : email,
    'password' : password,
  };
}
