class SubjectModel {
  Data? data;

  SubjectModel({this.data});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Subjects>? subjects;

  Data({this.subjects});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? subjectName;
  List<Chapters>? chapters;

  Subjects({this.subjectName, this.chapters});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectName = json['subjectName'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectName'] = subjectName;
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  String? chapterName;
  List<Topics>? topics;

  Chapters({this.chapterName, this.topics});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterName = json['chapter_name'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_name'] = chapterName;
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? topicName;
  String? noteName;
  List<String>? scribe;

  Topics({this.topicName, this.noteName, this.scribe});

  Topics.fromJson(Map<String, dynamic> json) {
    topicName = json['topic_name'];
    noteName = json['note_name'];
    scribe = json['scribe'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topic_name'] = topicName;
    data['note_name'] = noteName;
    data['scribe'] = scribe;
    return data;
  }
}
