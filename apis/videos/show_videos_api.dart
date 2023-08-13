import 'dart:convert';
import 'dart:developer';
import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> showVideosApi(String videoName) async {
  try {
    final response = await http.get(Uri.parse(
        '${ApiConstants.BASE_URL}${ApiConstants.SHOW_ONLINE_VIDEOS}/$videoName'));
    log(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic>? jsonResponse = json.decode(response.body);
      log(jsonResponse.toString());
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    log(error.toString());
  }
  return null;
}
