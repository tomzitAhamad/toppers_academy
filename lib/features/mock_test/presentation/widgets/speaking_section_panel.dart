import 'package:flutter/material.dart';

class SpeakingSectionPanel extends StatelessWidget {
  final bool isRecording;
  final bool hasRecord;
  final int recordingSeconds;
  final bool isPlaying;
  final double playProgress;
  final double playbackProgressSeconds;
  final Animation<double> pulseAnimation;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onResetRecording;
  final VoidCallback onTogglePlayback;
  final ValueChanged<double> onPlayProgressChanged;
  final String Function(int) formatDuration;

  const SpeakingSectionPanel({
    super.key,
    required this.isRecording,
    required this.hasRecord,
    required this.recordingSeconds,
    required this.isPlaying,
    required this.playProgress,
    required this.playbackProgressSeconds,
    required this.pulseAnimation,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onResetRecording,
    required this.onTogglePlayback,
    required this.onPlayProgressChanged,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          if (!hasRecord) ...[
            Stack(
              alignment: Alignment.center,
              children: [
                if (isRecording) ...[
                  // Pulsing ring 1
                  AnimatedBuilder(
                    animation: pulseAnimation,
                    builder: (context, child) {
                      return Container(
                        width: 80 * pulseAnimation.value,
                        height: 80 * pulseAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFA400FF).withValues(
                            alpha: 0.15 * (1.0 - (pulseAnimation.value - 1.0) / 0.6),
                          ),
                        ),
                      );
                    },
                  ),
                  // Pulsing ring 2
                  AnimatedBuilder(
                    animation: pulseAnimation,
                    builder: (context, child) {
                      final val = 1.0 + ((pulseAnimation.value - 1.0 + 0.3) % 0.6);
                      return Container(
                        width: 80 * val,
                        height: 80 * val,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFA400FF).withValues(
                            alpha: 0.1 * (1.0 - (val - 1.0) / 0.6),
                          ),
                        ),
                      );
                    },
                  ),
                ],
                GestureDetector(
                  onTap: isRecording ? onStopRecording : onStartRecording,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isRecording ? const Color(0xFFEF4444) : const Color(0xFFF2E2FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isRecording ? Icons.stop : Icons.mic,
                      color: isRecording ? Colors.white : const Color(0xFFA400FF),
                      size: isRecording ? 32 : 38,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              isRecording
                  ? 'Recording... ${formatDuration(recordingSeconds)}'
                  : 'Tap to record response',
              style: TextStyle(
                color: isRecording ? const Color(0xFFEF4444) : const Color(0xFF0F172A),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isRecording
                  ? 'Tap the red button to stop and save your response.'
                  : 'Make sure your microphone is working and you are in a quiet room.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ] else ...[
            // Custom premium audio playback widget for recorded response
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFF3E8FF),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2E2FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_voice,
                          color: Color(0xFFA400FF),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recorded Response',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Duration: ${formatDuration(recordingSeconds)}',
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onResetRecording,
                        icon: const Icon(
                          Icons.refresh,
                          color: Color(0xFFEF4444),
                          size: 16,
                        ),
                        label: const Text(
                          'Re-record',
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onTogglePlayback,
                        icon: Icon(
                          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: const Color(0xFFA400FF),
                          size: 36,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: const Color(0xFFA400FF),
                            inactiveTrackColor: const Color(0xFFE9D5FF),
                            thumbColor: const Color(0xFFA400FF),
                            overlayColor: const Color(0xFFA400FF).withValues(alpha: 0.12),
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                          ),
                          child: Slider(
                            value: playProgress.clamp(0.0, 1.0),
                            onChanged: onPlayProgressChanged,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${formatDuration(playbackProgressSeconds.toInt())} / ${formatDuration(recordingSeconds)}',
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
