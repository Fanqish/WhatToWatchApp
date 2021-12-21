// import 'package:hive/hive.dart';
import 'dart:convert';
// import 'dart:io';

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['name'],
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

void main() async {
  // Hive.init(Directory.current.path);
  // await Hive.openBox("Test");
  // print(Hive.box("Test").toMap());
}
