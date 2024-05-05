class SpeechModel {
  double paragraphAccuracy;
  double paragraphCompleteness;
  double paragraphFluency;
  List<dynamic> wordList;

  SpeechModel.fromJson(Map<String, dynamic> json)
      : paragraphAccuracy = json['paragraphAccuracy'],
        paragraphCompleteness = json['paragraphCompleteness'],
        paragraphFluency = json['paragraphFluency'],
        wordList = json['wordList'];
}
