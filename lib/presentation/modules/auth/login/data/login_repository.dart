// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> loginUser(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('usuarios')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        if (userData['password'] == password) {
          return true;
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error en el inicio de sesión: $e');
    }

    return false;
  }
}
