import 'package:flutter/material.dart';

class WritingEssayInput extends StatefulWidget {
  final String initialText;
  final ValueChanged<String> onChanged;

  const WritingEssayInput({
    super.key,
    required this.initialText,
    required this.onChanged,
  });

  @override
  State<WritingEssayInput> createState() => _WritingEssayInputState();
}

class _WritingEssayInputState extends State<WritingEssayInput> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  void didUpdateWidget(covariant WritingEssayInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialText != widget.initialText &&
        _textController.text != widget.initialText) {
      _textController.text = widget.initialText;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  int get _wordCount {
    return _textController.text
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          maxLines: 15,
          controller: _textController,
          onChanged: (text) {
            widget.onChanged(text);
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Write your essay response here (minimum 250 words)...',
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Words: $_wordCount',
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
