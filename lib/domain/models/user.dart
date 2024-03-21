
import 'dart:convert';

class User {
    String? email;
    String? password;
    String? name;
    String? photo;
    String? token;
    String? phone;

    User({
        this.email,
        this.password,
        this.name,
        this.photo,
        this.token,
        this.phone,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        photo: json["photo"],
        token: json["token"],
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "name": name,
        "photo": photo,
        "token": token,
        "phone": phone,
    };
}
