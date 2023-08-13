class ClassModel {
  String? className;
  String? filePath;
  int? id;
  int? boardsId;

  ClassModel({this.className, this.filePath, this.id, this.boardsId});

  ClassModel.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    filePath = json['file_path'];
    id = json['id'];
    boardsId = json['boards_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_name'] = className;
    data['file_path'] = filePath;
    data['id'] = id;
    data['boards_id'] = boardsId;
    return data;
  }
}
