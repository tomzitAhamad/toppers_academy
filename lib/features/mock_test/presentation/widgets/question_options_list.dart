import 'package:flutter/material.dart';

class QuestionOptionsList extends StatelessWidget {
  final String questionId;
  final List<String> options;
  final int? selectedOptionIndex;
  final Function(int) onOptionSelected;

  const QuestionOptionsList({
    super.key,
    required this.questionId,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = selectedOptionIndex == index;
        final optionLetter = String.fromCharCode(65 + index); // A, B, C, D

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => onOptionSelected(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF5F3FF) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4F39F6)
                      : const Color(0xFFE2E8F0),
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '$optionLetter. ',
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF4F39F6)
                          : const Color(0xFF0F172A),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF4F39F6)
                            : const Color(0xFF334155),
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
