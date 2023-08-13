import 'dart:convert';
import 'dart:developer';
import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> checkLicensApi(String licenseKeys) async {
  try {
    var url = Uri.parse(
        "${ApiConstants.BASE_URL}${ApiConstants.CHECK_LICENSE}/$licenseKeys");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic>? jsonResponse =
          json.decode(response.body);
      log(jsonResponse.toString());

      return jsonResponse;
    } else {
      print("failed");
    }
  } catch (error) {
    throw Exception(error);
  }
  return null;
}
