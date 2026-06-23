import 'package:flutter/material.dart';

enum MockTestSection {
  listening,
  reading,
  writing,
  speaking;

  String get label => switch (this) {
    MockTestSection.listening => 'Listening',
    MockTestSection.reading => 'Reading',
    MockTestSection.writing => 'Writing',
    MockTestSection.speaking => 'Speaking',
  };

  IconData get icon => switch (this) {
    MockTestSection.listening => Icons.volume_up_outlined,
    MockTestSection.reading => Icons.menu_book_outlined,
    MockTestSection.writing => Icons.edit_outlined,
    MockTestSection.speaking => Icons.mic_none_outlined,
  };

  Color get color => switch (this) {
    MockTestSection.listening => const Color(0xFF146BFF),
    MockTestSection.reading => const Color(0xFF10B981),
    MockTestSection.writing => const Color(0xFFF97316),
    MockTestSection.speaking => const Color(0xFFA400FF),
  };

  Color get bgColor => switch (this) {
    MockTestSection.listening => const Color(0xFFDDEBFF),
    MockTestSection.reading => const Color(0xFFD1FAE5),
    MockTestSection.writing => const Color(0xFFFFEDD5),
    MockTestSection.speaking => const Color(0xFFF2E2FF),
  };
}
