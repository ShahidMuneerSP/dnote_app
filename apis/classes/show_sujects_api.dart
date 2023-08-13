import 'dart:convert';
import 'dart:developer';

import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:dnote_2_0/models/subject_model.dart';
import 'package:http/http.dart' as http;

Future<SubjectModel?> showSubjectsApi(int classId, int boardId) async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.SHOW_SUBJECTS}/{id}/$boardId?class_id=$classId");
    Map<String, String> headers = {'Accept': 'application/json'};
    var response = await http.get(url, headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      final resultData = SubjectModel.fromJson(jsonDecode(response.body));
      return resultData;
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
