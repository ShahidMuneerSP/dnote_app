import 'package:get/get.dart';

class QuizScreenController extends GetxController {
  final currentIndex = 0.obs;

  updateCurrentIndex(int index) {
    currentIndex(index);
  }
}
