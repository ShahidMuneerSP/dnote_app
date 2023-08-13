import 'dart:developer';

import 'package:dnote_2_0/apis/classes/show_sujects_api.dart';
import 'package:dnote_2_0/models/subject_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList<Subjects> data = <Subjects>[].obs;
  RxBool isActivated = false.obs;

  RxBool isLoading = true.obs;

  getData(int classId, int boardId) async {
    isLoading(true);
    log("getting data..");

    final list = await showSubjectsApi(classId, boardId);

    if (list != null) {
      data(list.data?.subjects);
    }

    isLoading(false);
  }
}
