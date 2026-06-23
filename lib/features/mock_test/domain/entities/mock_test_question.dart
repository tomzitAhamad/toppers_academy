import 'mock_test_section.dart';

class MockTestQuestion {
  final String id;
  final int questionNumber;
  final MockTestSection section;
  final String questionText;
  final List<String> options;
  final int correctOption;
  final String? audioPath;
  final String? audioDuration;

  const MockTestQuestion({
    required this.id,
    required this.questionNumber,
    required this.section,
    required this.questionText,
    required this.options,
    required this.correctOption,
    this.audioPath,
    this.audioDuration,
  });
}
