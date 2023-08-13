class VideoModel {
  String? url;
  String? videoName;
  int? id;

  VideoModel({this.url, this.videoName, this.id});

  VideoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    videoName = json['video_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['video_name'] = videoName;
    data['id'] = id;
    return data;
  }
}
