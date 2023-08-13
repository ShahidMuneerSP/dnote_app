import 'dart:convert';
import 'dart:developer';

import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<bool> postVideoApi({
  required String videoName,
  required String url,
}) async {
  try {
    print("started upload ??");
    final url =
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.CREATE_ONLINE_VIDEO);

    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> msg = {
      'video_name': videoName.toString(),
      "url": url.toString(),
    };

    final response =
        await http.post(url, body: json.encode(msg), headers: headers);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.body);
      print("Successfully Added");
      return true;
    } else {
      print("Error while posting data");
    }
  } catch (e) {
    print("Exception occured");
    log(e.toString());
  }
  return false;
}
