import 'dart:developer';

import 'package:dnote_2_0/Constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<bool> createUserApi(
    {required String userName,
    required String imei,
    required String licenseKey,
    required String activeClass,
    required String phoneNumber}) async {
  try {
    print("started upload ??");
    final url =
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.CREATE_ACTIVE_USER);

    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> msg = {
      'users_name': userName.toString(),
      "imei": imei.toString(),
      "license_key": licenseKey.toString(),
      "active_class": activeClass.toString(),
      "payment_id": 1.toString(),
      "phone_num": phoneNumber.toString()
    };

    final response = await http.post(url, body: msg, headers: headers);
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
