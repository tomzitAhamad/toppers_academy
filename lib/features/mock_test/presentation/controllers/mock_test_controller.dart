import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/mock_test_question.dart';
import '../../domain/entities/mock_test_section.dart';

class MockTestController extends ChangeNotifier {
  MockTestController() {
    _initializeQuestions();
    _startTimer();
  }

  // Timer State
  Timer? _timer;
  int _secondsRemaining = 2700; // 45 minutes
  bool _isDisposed = false;

  // Active section & question state
  MockTestSection _activeSection = MockTestSection.listening;
  final Map<MockTestSection, int> _currentQuestionIndices = {
    MockTestSection.listening: 0,
    MockTestSection.reading: 0,
    MockTestSection.writing: 0,
    MockTestSection.speaking: 0,
  };

  // Answers State: maps question.id to selected option index
  final Map<String, int> _selectedAnswers = {};

  // Writing essay answer state
  String _essayText = '';

  // Audio Playback Simulation (for Listening Section)
  bool _isAudioPlaying = false;
  double _audioProgress = 0.0;
  Timer? _audioTimer;

  // Questions Database
  final List<MockTestQuestion> _questions = [];

  // Getters
  MockTestSection get activeSection => _activeSection;
  int get secondsRemaining => _secondsRemaining;
  bool get isAudioPlaying => _isAudioPlaying;
  double get audioProgress => _audioProgress;
  String get essayText => _essayText;

  String get formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  List<MockTestQuestion> get currentSectionQuestions {
    return _questions.where((q) => q.section == _activeSection).toList();
  }

  int get currentQuestionIndex => _currentQuestionIndices[_activeSection] ?? 0;

  MockTestQuestion? get currentQuestion {
    final list = currentSectionQuestions;
    if (list.isEmpty || currentQuestionIndex >= list.length) return null;
    return list[currentQuestionIndex];
  }

  int? getSelectedAnswer(String questionId) => _selectedAnswers[questionId];

  void selectOption(String questionId, int optionIndex) {
    _selectedAnswers[questionId] = optionIndex;
    notifyListeners();
  }

  void updateEssayText(String text) {
    _essayText = text;
    notifyListeners();
  }

  void changeSection(MockTestSection section) {
    if (_activeSection == section) return;
    _activeSection = section;
    _stopAudio();
    notifyListeners();
  }

  void nextQuestion() {
    final list = currentSectionQuestions;
    final currentIndex = currentQuestionIndex;
    if (currentIndex < list.length - 1) {
      _currentQuestionIndices[_activeSection] = currentIndex + 1;
      _stopAudio();
      notifyListeners();
    }
  }

  void previousQuestion() {
    final currentIndex = currentQuestionIndex;
    if (currentIndex > 0) {
      _currentQuestionIndices[_activeSection] = currentIndex - 1;
      _stopAudio();
      notifyListeners();
    }
  }

  // Audio actions
  void toggleAudio() {
    if (_isAudioPlaying) {
      _stopAudio();
    } else {
      _startAudio();
    }
  }

  void _startAudio() {
    _isAudioPlaying = true;
    _audioProgress = 0.0;
    notifyListeners();

    _audioTimer?.cancel();
    _audioTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_audioProgress >= 1.0) {
        _stopAudio();
      } else {
        _audioProgress += 0.006; // roughly 16 seconds total for simulation
        if (_audioProgress > 1.0) _audioProgress = 1.0;
        notifyListeners();
      }
    });
  }

  void _stopAudio() {
    _isAudioPlaying = false;
    _audioTimer?.cancel();
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _initializeQuestions() {
    _questions.addAll([
      // LISTENING
      const MockTestQuestion(
        id: 'list-q1',
        questionNumber: 1,
        section: MockTestSection.listening,
        questionText:
            'What is the main purpose of the speaker\'s presentation?',
        options: [
          'To explain a new policy',
          'To announce a product launch',
          'To provide training instructions',
          'To discuss market trends',
        ],
        correctOption: 2,
        audioPath: 'audio_track_1.mp3',
        audioDuration: '2:45',
      ),
      const MockTestQuestion(
        id: 'list-q2',
        questionNumber: 2,
        section: MockTestSection.listening,
        questionText: 'What resource does the speaker recommend using first?',
        options: [
          'The course syllabus list',
          'The online student library portal',
          'The printed guidance handbook',
          'The peer tutoring community platform',
        ],
        correctOption: 1,
        audioPath: 'audio_track_2.mp3',
        audioDuration: '1:30',
      ),

      // READING
      const MockTestQuestion(
        id: 'read-q1',
        questionNumber: 1,
        section: MockTestSection.reading,
        questionText:
            'According to paragraph 2, why has language learning software become popular?',
        options: [
          'It offers personalized gamification',
          'It is cheaper than tutor lessons',
          'It provides instant speech analytics',
          'It runs offline on multiple devices',
        ],
        correctOption: 0,
      ),
      const MockTestQuestion(
        id: 'read-q2',
        questionNumber: 2,
        section: MockTestSection.reading,
        questionText:
            'What does the writer suggest about traditional classrooms in paragraph 4?',
        options: [
          'They will soon become completely obsolete',
          'They remain essential for social fluency',
          'They require massive budget restructuring',
          'They ignore writing and reading exercises',
        ],
        correctOption: 1,
      ),

      // WRITING
      const MockTestQuestion(
        id: 'write-q1',
        questionNumber: 1,
        section: MockTestSection.writing,
        questionText:
            'Writing Task 2: Some people believe that university education should be completely free for everyone. Other people think that students should pay for their tertiary study. Discuss both views and give your opinion.\n\nWrite at least 250 words.',
        options: [],
        correctOption: -1,
      ),

      // SPEAKING
      const MockTestQuestion(
        id: 'speak-q1',
        questionNumber: 1,
        section: MockTestSection.speaking,
        questionText:
            'Speaking Part 1: Description of your home town.\n\n- Where is your hometown located?\n- What do you like most about it?\n- Has it changed much since you were a child?',
        options: [],
        correctOption: -1,
      ),
    ]);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    _audioTimer?.cancel();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }
}
