import 'dart:developer';

import 'package:dnote_2_0/apis/boards/get_all_boards.dart';
import 'package:dnote_2_0/apis/classes/get_all_classes.dart';
import 'package:dnote_2_0/models/boards_model.dart';
import 'package:dnote_2_0/models/class_model.dart';
import 'package:get/get.dart';

import '../apis/classes/get_all_classes_by_board.dart';

class ClassSelectionScreenController extends GetxController {
  RxBool isLoading = true.obs;

  RxList<ClassModel> data = <ClassModel>[].obs;
  // RxList<BoardsModel> boardData = <BoardsModel>[].obs;
  // getBoardData() async {
  //   isLoading(true);
  //   log("getting board data..");

  //   var newList = await getAllBoards();

  //   if (newList != null) {
  //     boardData.clear();
  //     for (var element in newList) {
  //       boardData.add(element);
  //     }
  //   }

  //   isLoading(false);
  // }

  getData(int id) async {
    isLoading(true);
    log("getting classes data..");

    var list = await getAllClassesByBoard(id);
    

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }

    isLoading(false);
  }
}
