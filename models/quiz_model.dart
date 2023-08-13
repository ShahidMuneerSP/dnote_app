import 'package:cloud_firestore/cloud_firestore.dart';

class QuizOptions {
  QuizOptions({this.options, this.isSelected});
  String? options;
  bool? isSelected;
}

var quiz = FirebaseFirestore.instance.collection("CBSe").snapshots();
