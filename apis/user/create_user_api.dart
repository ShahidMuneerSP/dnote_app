// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';
import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<bool> createUsersApi(String username, String phoneNo, String address,
    String userClass, String schoolName,String boardId) async {
  try {
    print("started upload ??");

    final url =
        Uri.parse("${ApiConstants.BASE_URL}${ApiConstants.CREATE_USER}");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-dsn': 'abcd-abcd'
    };

    Map<String, dynamic> json = {
      "username": username,
      "phone_no": phoneNo,
      "address": address,
      "user_class": userClass,
      "school_name": schoolName,
      "board_id":boardId,
    };

    final response =
        await http.post(url, body: jsonEncode(json), headers: headers);

    print(response.body);
    log(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Successfully Added");
      return true;
    } else {
      print("Error while adding data");
    }
  } catch (e) {
    print("Exception occured");
    log(e.toString());
  }
  return false;
}
