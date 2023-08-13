import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDB {
  Future readQuiz() async {
    return FirebaseFirestore.instance.collection('chapterQuiz').snapshots();
  }
}
