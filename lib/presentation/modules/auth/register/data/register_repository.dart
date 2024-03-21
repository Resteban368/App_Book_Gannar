// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterRepository {
  final databseReference = FirebaseFirestore.instance.collection('usuarios');

  Future<bool> registerUser(String email, String password, String name,
      String photo,  String phone) async {
    try {
      String id = databseReference.doc().id;

      await FirebaseFirestore.instance.collection('usuarios').doc(id).set({
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        "photo": photo == ""
            ? "https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg"
            : photo,
        'phone': phone,
      });
      return true;
    } catch (e, s) {
      print("Error al registrar usuario: $e +++ $s");
      return false;
    }
  }
}
