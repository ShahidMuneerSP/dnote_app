import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mycontroller extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var location = ''.obs;
  var schoolName = ''.obs;
  var selectedClass = ''.obs;
  var selectedBoard = ''.obs;

  Future<void> addClassAndBoard() {
    final classAndBoard = FirebaseFirestore.instance.collection('users');

    return classAndBoard
        .add({'class': selectedClass, 'board': selectedBoard})
        .then((value) => print("select class"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUserDetails() {
    final userDB = FirebaseDatabase.instance.ref('users');

    return userDB.ref.set({
      'name': "",
      'phoneNumber': '',
      'location': '',
      'schoolName': schoolName,
      'class': selectedClass,
      'board': selectedBoard,
    });
  }
}
