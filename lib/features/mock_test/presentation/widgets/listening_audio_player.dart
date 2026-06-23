import 'package:flutter/material.dart';

class ListeningAudioPlayer extends StatelessWidget {
  final String audioPath;
  final String duration;
  final bool isPlaying;
  final double progress;
  final VoidCallback onTogglePlay;

  const ListeningAudioPlayer({
    super.key,
    required this.audioPath,
    required this.duration,
    required this.isPlaying,
    required this.progress,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDEBFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.volume_up, color: Color(0xFF146BFF), size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Audio Track 1',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF1E429F),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Row(
                  children: [
                    SizedBox(
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: onTogglePlay,
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.volume_up,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: Text(
                          isPlaying ? 'Pause' : 'Play Audio',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF146BFF),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(100, 36),
                          maximumSize: const Size(double.infinity, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Duration: $duration',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isPlaying) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF146BFF)),
            minHeight: 3.5,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ],
    );
  }
}
