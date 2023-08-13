
import 'package:get/get.dart';


class YoutubePlayerScreenController extends GetxController {
  RxString topicTitle = "".obs;
  final isVideoPlay = false.obs;

  RxBool isVideoLoading = false.obs;

  updateVideoPlay(bool status) {
    isVideoPlay(status);
  }
}
