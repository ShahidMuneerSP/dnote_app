import 'package:flutter/material.dart';

class Chapter {
  String? title;
  String? image;
  String? videoId;
  bool isPlaying;

  Chapter(
      {required this.title,
      required this.image,
      required this.videoId,
      required this.isPlaying});
}

List<Chapter> chapter = [
  Chapter(
      title: 'Light - Reflection & Refraction',
      image:
          'https://futurestudypoint.com/wp-content/uploads/2019/11/refl.refr_.disp_.png',
      videoId: '674904051',
      isPlaying: false),
  Chapter(
      title: 'Human Eye & Colorfull World',
      image:
          'https://img.jagranjosh.com/imported/images/E/Articles/human_eye_image.jpg',
      videoId: '36559157',
      isPlaying: false),
  Chapter(
      title: 'Electricity',
      image:
          'https://theengineeringmindset.com/wp-content/uploads/2018/01/how-electricity-works-thumbnail.jpg',
      videoId: '683148579',
      isPlaying: false),
  Chapter(
      title: 'Magnetic Effects of Electric Current',
      image: 'https://i.ytimg.com/vi/gEvgI70RB4g/maxresdefault.jpg',
      videoId: '683148579',
      isPlaying: false),
  Chapter(
    title: 'Source of Energy',
    image:
        'https://cdn.slidesharecdn.com/ss_thumbnails/sourcesofenergy-150602144639-lva1-app6892-thumbnail-4.jpg?cb=1433256760',
    videoId: '149315088',
    isPlaying: false,
  ),
];

class Quiz {
  int? id;
  String? Question;
  String? op1;
  String? op2;
  String? op3;
  String? op4;
  String? ans;

  Quiz({
    this.Question,
    this.id,
    this.op1,
    this.op2,
    this.op3,
    this.op4,
    this.ans,
  });
}

List<Quiz> quiz = [
  Quiz(
      id: 1,
      Question:
          'A full length image of a distant tall building can definitely be seen by using:',
      op1: 'a concave mirror',
      op2: 'a convex mirror',
      op3: 'a plane mirror',
      op4: 'both concave as well as plane mirror',
      ans: 'a convex mirror'),
  Quiz(
      id: 2,
      Question:
          'Your school laboratory has one large window. To find the focal length of a concave mirror using one of the walls as screen, the experiment may be performed:',
      op1: 'on the same wall as the window.',
      op2: 'on the wall adjacent to the window.',
      op3: 'on the wall opposite to the window.',
      op4: 'only on the table as per laboratory arrangement.',
      ans: 'on the wall adjacent to the window.'),
  Quiz(
    id: 3,
    Question:
        'In order to determine the focal length of a concave mirror by obtaining the Image of a distant object on screen, the position of the screen should be:',
    op1: 'parallel to the pLane of concave mirror',
    op2: 'perpendicular to the plane of concave mirror',
    op3: 'IncLined at an angle 600 to the plane of mirror',
    op4: 'in any direction with respect to the plane of concave mirror',
    ans: 'in any direction with respect to the plane of concave mirror',
  ),
  Quiz(
    id: 4,
    Question:
        'A student carries out the experiment of tracing the path of a ray of Light through a rectangular glass slab for two different values of angLe of incidence ∠i = 300 and ∠i = 45° In the two coses the student is likely to observe the set of vaLues of angle of refraction and angLe of emergence as',
    op1: '∠r =30, ∠e = 20° and ∠r = 45, ∠e = 28°',
    op2: '∠r =30°. ∠e = 30° and ∠r=45°, ∠e= 450',
    op3: '∠r =200, ∠e = 30° and ∠r = 28°, ∠e=45°',
    op4: '∠r =20°, ∠e = 20° and ∠r = 28°, ∠e = 28°',
    ans: '∠r =200, ∠e = 30° and ∠r = 28°, ∠e=45°',
  ),
  Quiz(
    id: 5,
    Question:
        'A full length image of a distant tall building can definitely be seen by using:',
    op1: 'a concave mirror',
    op2: ' a convex mirror',
    op3: 'a plane mirror',
    op4: 'both concave as well as plane mirror',
    ans: 'a plane mirror',
  ),
  Quiz(
    id: 6,
    Question:
        'Your school laboratory has one large window. To find the focal length of a concave mirror using one of the walls as screen, the experiment may be performed:',
    op1: 'on the same wall as the window.',
    op2: 'on the wall adjacent to the window.',
    op3: 'on the wall opposite to the window.',
    op4: 'only on the table as per laboratory arrangement.',
    ans: 'only on the table as per laboratory arrangement.',
  ),
  Quiz(
    id: 7,
    Question:
        'In order to determine the focal length of a concave mirror by obtaining the Image of a distant object on screen, the position of the screen should be:',
    op1: 'parallel to the pLane of concave mirror',
    op2: 'perpendicular to the plane of concave mirror',
    op3: 'IncLined at an angle 600 to the plane of mirror',
    op4: 'in any direction with respect to the plane of concave mirror',
    ans: 'in any direction with respect to the plane of concave mirror',
  ),
  Quiz(
    id: 8,
    Question:
        'A student carries out the experiment of tracing the path of a ray of Light through a rectangular glass slab for two different values of angLe of incidence ∠i = 300 and ∠i = 45° In the two coses the student is likely to observe the set of vaLues of angle of refraction and angLe of emergence as',
    op1: '∠r =30, ∠e = 20° and ∠r = 45, ∠e = 28°',
    op2: '∠r =30°. ∠e = 30° and ∠r=45°, ∠e= 450',
    op3: '∠r =200, ∠e = 30° and ∠r = 28°, ∠e=45°',
    op4: '∠r =20°, ∠e = 20° and ∠r = 28°, ∠e = 28°',
    ans: '∠r =20°, ∠e = 20° and ∠r = 28°, ∠e = 28°',
  ),
  Quiz(
    id: 9,
    Question:
        'A full length image of a distant tall building can definitely be seen by using:',
    op1: 'a concave mirror',
    op2: ' a convex mirror',
    op3: 'a plane mirror',
    op4: 'both concave as well as plane mirror',
    ans: 'a plane mirror',
  ),
  Quiz(
    id: 10,
    Question:
        'Your school laboratory has one large window. To find the focal length of a concave mirror using one of the walls as screen, the experiment may be performed:',
    op1: 'on the same wall as the window.',
    op2: 'on the wall adjacent to the window.',
    op3: 'on the wall opposite to the window.',
    op4: 'only on the table as per laboratory arrangement.',
    ans: 'on the wall opposite to the window.',
  )
];

class Option {
  final String? code;
  final String? text;
  final bool? isCorrect;

  Option({
    @required this.text,
    @required this.code,
    @required this.isCorrect,
  });
}

class QuestionData {
  final String? text;
  final String? id;
  final List<Option>? options;
  final String? solution;
  bool isLocked;
  Option? selectedOption;

  QuestionData({
    @required this.id,
    @required this.text,
    @required this.options,
    @required this.solution,
    this.isLocked = false,
    this.selectedOption,
  });
}

final questions = [
  QuestionData(
    id: '1',
    text: 'Which planet is the hottest in the solar system?',
    options: [
      Option(code: 'A', text: 'Earth', isCorrect: false),
      Option(code: 'B', text: 'Venus', isCorrect: true),
      Option(code: 'C', text: 'Jupiter', isCorrect: false),
      Option(code: 'D', text: 'Saturn', isCorrect: false),
    ],
    solution: 'Venus is the hottest planet in the solar system',
  ),
  QuestionData(
    id: '2',
    text: 'How many molecules of oxygen does ozone have?',
    options: [
      Option(code: 'A', text: '1', isCorrect: false),
      Option(code: 'B', text: '2', isCorrect: false),
      Option(code: 'C', text: '5', isCorrect: false),
      Option(code: 'D', text: '3', isCorrect: true),
    ],
    solution: 'Ozone have 3 molecules of oxygen',
  ),
  QuestionData(
    id: '3',
    text: 'What is the symbol for potassium?',
    options: [
      Option(code: 'A', text: 'N', isCorrect: false),
      Option(code: 'B', text: 'S', isCorrect: false),
      Option(code: 'C', text: 'P', isCorrect: false),
      Option(code: 'D', text: 'K', isCorrect: true),
    ],
    solution: 'The symbol for potassium is K',
  ),
  QuestionData(
    id: '4',
    text:
        'Which of these plays was famously first performed posthumously after the playwright committed suicide?',
    options: [
      Option(code: 'A', text: '4.48 Psychosis', isCorrect: true),
      Option(code: 'B', text: 'Hamilton', isCorrect: false),
      Option(code: 'C', text: "Much Ado About Nothing", isCorrect: false),
      Option(code: 'D', text: "The Birthday Party", isCorrect: false),
    ],
    solution: '4.48 Psychosis is the correct answer for this question',
  ),
  QuestionData(
    id: '5',
    text: 'What year was the very first model of the iPhone released?',
    options: [
      Option(code: 'A', text: '2005', isCorrect: false),
      Option(code: 'B', text: '2008', isCorrect: false),
      Option(code: 'C', text: '2007', isCorrect: true),
      Option(code: 'D', text: '2006', isCorrect: false),
    ],
    solution: 'iPhone was first released in 2007',
  ),
  QuestionData(
    id: '6',
    text: ' Which element is said to keep bones strong?',
    options: [
      Option(code: 'A', text: 'Carbon', isCorrect: false),
      Option(code: 'B', text: 'Oxygen', isCorrect: false),
      Option(code: 'C', text: 'Calcium', isCorrect: true),
      Option(
        code: 'D',
        text: 'Pottasium',
        isCorrect: false,
      ),
    ],
    solution: 'Calcium is the element responsible for keeping the bones strong',
  ),
  QuestionData(
    id: '7',
    text: 'What country won the very first FIFA World Cup in 1930?',
    options: [
      Option(code: 'A', text: 'Brazil', isCorrect: false),
      Option(code: 'B', text: 'Germany', isCorrect: false),
      Option(code: 'C', text: 'Italy', isCorrect: false),
      Option(code: 'D', text: 'Uruguay', isCorrect: true),
    ],
    solution: 'Uruguay was the first country to win world cup',
  ),
];
