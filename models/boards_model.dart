class BoardsModel {
  int? id;
  String? boardName;

  BoardsModel({this.id, this.boardName});

  BoardsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardName = json['board_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['board_name'] = boardName;
    return data;
  }
}
