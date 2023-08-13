import 'dart:developer';

import 'package:dnote_2_0/models/license_key_model.dart';
import 'package:get/get.dart';

import '../apis/license_key/all_license_key.dart';

class VerificationScreenController extends GetxController {
  RxList<LicenseKeyModel> data = <LicenseKeyModel>[].obs;
  getData() async {
    log("getting data..");

    var list = await getAllLicenseKeyApi();

    if (list != null) {
      data.clear();
      for (var element in list) {
        data.add(element);
      }
    }
  }
}
