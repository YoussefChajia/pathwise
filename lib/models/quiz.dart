class Quiz {
  final String question;
  final List<String> options;
  final List<int> correctAnswers;
  List<int> userAnswers;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswers,
    required this.userAnswers,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswers: List<int>.from(json['correctAnswers']),
      userAnswers: List<int>.from(json['userAnswers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswers': correctAnswers,
      'userAnswers': userAnswers,
    };
  }
}
