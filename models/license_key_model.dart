class LicenseKeyModel {
  String? licenseKeys;
  int? id;
  int? classId;

  LicenseKeyModel({this.licenseKeys, this.id, this.classId});

  LicenseKeyModel.fromJson(Map<String, dynamic> json) {
    licenseKeys = json['license_keys'];
    id = json['id'];
    classId = json['class_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['license_keys'] = licenseKeys;
    data['id'] = id;
    data['class_id'] = classId;
    return data;
  }
}
