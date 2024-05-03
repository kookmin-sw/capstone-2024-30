class AnswerModel {
  int id;
  int questionId;
  String author;
  String mainText;
  DateTime? datePublished;
  DateTime? dateUpdated;
  String email;

  AnswerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        questionId = json['question_id'] as int,
        author = json['author'] as String,
        mainText = json['mainText'] as String,
        datePublished = json['date_published'] == null
            ? null
            : DateTime.tryParse(json['date_published'] as String),
        dateUpdated = json['date_updated'] == null
            ? null
            : DateTime.tryParse(json['date_updated'] as String),
        email = json['email'] as String;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'author': author,
      'mainText': mainText,
      'date_published': datePublished,
      'date_updated': dateUpdated,
      'email': email,
    };
  }
}
