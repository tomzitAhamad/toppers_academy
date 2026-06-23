import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../domain/entities/mock_test_section.dart';
import '../controllers/mock_test_controller.dart';
import '../widgets/listening_audio_player.dart';
import '../widgets/question_options_list.dart';
import '../widgets/writing_essay_input.dart';
import '../widgets/speaking_section_panel.dart';

class MockTestActivePage extends StatefulWidget {
  const MockTestActivePage({super.key});

  @override
  State<MockTestActivePage> createState() => _MockTestActivePageState();
}

class _MockTestActivePageState extends State<MockTestActivePage>
    with SingleTickerProviderStateMixin {
  late final MockTestController _controller;

  // Speaking section simulated states
  bool _isRecording = false;
  bool _hasRecord = false;
  int _recordingSeconds = 0;
  Timer? _recordingTimer;

  bool _isPlaying = false;
  double _playProgress = 0.0;
  Timer? _playbackTimer;
  double _playbackProgressSeconds = 0.0;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = MockTestController()..addListener(_onStateChange);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChange);
    _controller.dispose();
    _recordingTimer?.cancel();
    _playbackTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _onStateChange() {
    if (mounted) {
      if (_controller.activeSection != MockTestSection.speaking) {
        _resetRecording();
      }
      setState(() {});
    }
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _hasRecord = false;
      _recordingSeconds = 0;
      _playProgress = 0.0;
    });

    _pulseController.repeat();

    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingSeconds++;
      });
    });
  }

  void _stopRecording() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _pulseController.stop();
    _pulseController.reset();

    setState(() {
      _isRecording = false;
      _hasRecord = true;
    });
  }

  void _resetRecording() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _playbackTimer?.cancel();
    _playbackTimer = null;
    if (mounted) {
      _pulseController.stop();
      _pulseController.reset();
    }

    setState(() {
      _isRecording = false;
      _hasRecord = false;
      _recordingSeconds = 0;
      _isPlaying = false;
      _playProgress = 0.0;
      _playbackProgressSeconds = 0.0;
    });
  }

  void _startPlayback() {
    if (_recordingSeconds == 0) return;
    setState(() {
      _isPlaying = true;
      if (_playProgress >= 1.0) {
        _playProgress = 0.0;
        _playbackProgressSeconds = 0.0;
      }
    });

    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _playbackProgressSeconds += 0.1;
        if (_playbackProgressSeconds >= _recordingSeconds) {
          _playbackProgressSeconds = _recordingSeconds.toDouble();
          _playProgress = 1.0;
          _isPlaying = false;
          _playbackTimer?.cancel();
          _playbackTimer = null;
        } else {
          _playProgress = _playbackProgressSeconds / _recordingSeconds;
        }
      });
    });
  }

  void _pausePlayback() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
    setState(() {
      _isPlaying = false;
    });
  }

  void _togglePlayback() {
    if (_isPlaying) {
      _pausePlayback();
    } else {
      _startPlayback();
    }
  }

  void _confirmExit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Test?'),
        content: const Text(
          'Are you sure you want to exit? Your current progress will not be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back to details
            },
            child: const Text('Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Test?'),
        content: const Text(
          'Are you ready to submit your answers for grading?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // exit active test
              Navigator.pop(context); // exit details page back to dashboard
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mock Test submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F39F6),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _controller.currentQuestion;
    final questionsList = _controller.currentSectionQuestions;
    final isFirstQuestion = _controller.currentQuestionIndex == 0;
    final isLastQuestion =
        _controller.currentQuestionIndex == questionsList.length - 1;
    final isLastSection = _controller.activeSection == MockTestSection.speaking;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: _confirmExit,
        ),
        title: const Text(
          'Mock Test #3',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          // Timer Badge
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF4F39F6),
                  size: 16,
                ),
                const SizedBox(width: 6),
                AppAnimatedText(
                  value: _controller.formattedTime,
                  style: const TextStyle(
                    color: Color(0xFF4F39F6),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Horizontal Section Tabs
          Container(
            color: Colors.white,
            child: Row(
              children: MockTestSection.values.map((section) {
                final isActive = _controller.activeSection == section;
                return Expanded(
                  child: InkWell(
                    onTap: () => _controller.changeSection(section),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Icon(
                          section.icon,
                          color: isActive
                              ? const Color(0xFF4F39F6)
                              : const Color(0xFF64748B),
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          section.label,
                          style: TextStyle(
                            color: isActive
                                ? const Color(0xFF4F39F6)
                                : const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: isActive
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Indigo bottom active bar indicator
                        AnimatedContainer(
                          duration: AppAnimations.fast,
                          curve: AppAnimations.enterCurve,
                          height: 2.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF4F39F6)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 2. Banner: Autosave indicator
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD1FAE5)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF10B981),
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your answers are automatically saved',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Question / Interaction Card Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  if (currentQuestion != null)
                    AnimatedSwitcher(
                      duration: AppAnimations.standard,
                      switchInCurve: AppAnimations.enterCurve,
                      switchOutCurve: AppAnimations.exitCurve,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.04, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        key: ValueKey(
                          '${_controller.activeSection.name}-${currentQuestion.id}',
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Question ${currentQuestion.questionNumber}',
                                  style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _controller.activeSection.label,
                                    style: const TextStyle(
                                      color: Color(0xFF475569),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Listening Section specific audio player
                            if (_controller.activeSection ==
                                    MockTestSection.listening &&
                                currentQuestion.audioPath != null) ...[
                              ListeningAudioPlayer(
                                audioPath: currentQuestion.audioPath!,
                                duration: currentQuestion.audioDuration!,
                                isPlaying: _controller.isAudioPlaying,
                                progress: _controller.audioProgress,
                                onTogglePlay: _controller.toggleAudio,
                              ),
                              const SizedBox(height: 18),
                            ],

                            // Question text
                            Text(
                              currentQuestion.questionText,
                              style: const TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Render options based on section
                            if (_controller.activeSection ==
                                    MockTestSection.listening ||
                                _controller.activeSection ==
                                    MockTestSection.reading)
                              QuestionOptionsList(
                                questionId: currentQuestion.id,
                                options: currentQuestion.options,
                                selectedOptionIndex: _controller
                                    .getSelectedAnswer(currentQuestion.id),
                                onOptionSelected: (index) => _controller
                                    .selectOption(currentQuestion.id, index),
                              )
                            else if (_controller.activeSection ==
                                MockTestSection.writing)
                              WritingEssayInput(
                                initialText: _controller.essayText,
                                onChanged: _controller.updateEssayText,
                              )
                            else if (_controller.activeSection ==
                                MockTestSection.speaking)
                              SpeakingSectionPanel(
                                isRecording: _isRecording,
                                hasRecord: _hasRecord,
                                recordingSeconds: _recordingSeconds,
                                isPlaying: _isPlaying,
                                playProgress: _playProgress,
                                playbackProgressSeconds:
                                    _playbackProgressSeconds,
                                pulseAnimation: _pulseAnimation,
                                onStartRecording: _startRecording,
                                onStopRecording: _stopRecording,
                                onResetRecording: _resetRecording,
                                onTogglePlayback: _togglePlayback,
                                onPlayProgressChanged: (val) {
                                  setState(() {
                                    _playProgress = val;
                                    _playbackProgressSeconds =
                                        val * _recordingSeconds;
                                  });
                                  if (_isPlaying) {
                                    _startPlayback();
                                  }
                                },
                                formatDuration: _formatDuration,
                              ),
                            const SizedBox(height: 20),

                            // Previous/Next Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  onPressed: isFirstQuestion
                                      ? null
                                      : _controller.previousQuestion,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: isFirstQuestion
                                          ? const Color(0xFFCBD5E1)
                                          : const Color(0xFFE2E8F0),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: const Size(120, 46),
                                  ),
                                  child: Text(
                                    'Previous',
                                    style: TextStyle(
                                      color: isFirstQuestion
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF334155),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (isLastQuestion) {
                                      if (isLastSection) {
                                        _confirmSubmit();
                                      } else {
                                        // Switch to next section
                                        final nextSection =
                                            MockTestSection.values[_controller
                                                    .activeSection
                                                    .index +
                                                1];
                                        _controller.changeSection(nextSection);
                                      }
                                    } else {
                                      _controller.nextQuestion();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4F39F6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: const Size(120, 46),
                                  ),
                                  child: Text(
                                    isLastQuestion
                                        ? (isLastSection
                                              ? 'Submit'
                                              : 'Next Section')
                                        : 'Next',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // 4. Bottom Alert: Exam Tips
                  AppReveal(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFEF3C7)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.error_outline,
                              color: Color(0xFFD97706),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exam Tips',
                                  style: TextStyle(
                                    color: Color(0xFF92400E),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'You can navigate between questions at any time. Make sure to answer all questions before submitting.',
                                  style: TextStyle(
                                    color: Color(0xFF78350F),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
