class Quiz {
  final String question;
  final bool answer;
  final bool isAnswered;
  final bool? userAnswer;

  const Quiz({
    required this.question,
    required this.answer,
    this.isAnswered = false,
    this.userAnswer,
  });

  Quiz copyWith({bool? isAnswered, bool? userAnswer}) {
    return Quiz(
      question: question,
      answer: answer,
      isAnswered: isAnswered ?? this.isAnswered,
      userAnswer: userAnswer ?? this.userAnswer,
    );
  }
}
