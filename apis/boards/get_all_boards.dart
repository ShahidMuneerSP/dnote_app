import 'dart:convert';
import 'dart:developer';

import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../../models/boards_model.dart';

Future<List<BoardsModel>?> getAllBoards() async {
  try {
    var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET_ALL_BOARDS);
    Map<String, String> headers = {'Accept': 'application/json'};

    var response = await http.get(url, headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      List resultData = jsonDecode(response.body);
      List<BoardsModel> boards = [];

      ///insert api data to a list
      for (var element in resultData) {
        boards.add(BoardsModel.fromJson(element));
      }
      return boards;
    } else {}
  } catch (e) {
    if (e.toString().contains('Connection failed')) {
      print('Please check your internet connection and try again..');
    } else {
      print('Something went wrong..');
    }

    print(e.toString());
  }

  return null;
}
