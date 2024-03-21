import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gannar/domain/models/user.dart';

class ProfileRepository {
  final databseReference = FirebaseFirestore.instance.collection('usuarios');

//meotod para obtener un usuario por su token que guarde en firebase
  Future<User> getUserByToken(String token) async {
    try {
      final querySnapshot = await databseReference.where('token', isEqualTo: token).get();
      if (querySnapshot.docs.isNotEmpty) {
        return User.fromMap(querySnapshot.docs.first.data());
      }
      return User();
    } catch (e, s) {
      print('ERROR GET USER BY TOKEN $e $s');
      return User();
  }
}
}