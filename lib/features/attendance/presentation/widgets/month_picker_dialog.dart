import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const MonthPickerDialog({super.key, required this.initialDate});

  static Future<DateTime?> show(BuildContext context, DateTime initialDate) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => MonthPickerDialog(initialDate: initialDate),
    );
  }

  @override
  State<MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  late DateTime _tempDate;

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _tempDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Select Month & Year',
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Color(0xFF4B5563),
                ),
                onPressed: () {
                  setState(() {
                    _tempDate = DateTime(_tempDate.year - 1, _tempDate.month);
                  });
                },
              ),
              Text(
                '${_tempDate.year}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color(0xFF4B5563),
                ),
                onPressed: () {
                  setState(() {
                    _tempDate = DateTime(_tempDate.year + 1, _tempDate.month);
                  });
                },
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          SizedBox(
            width: 320,
            height: 200,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final monthName = _months[index].substring(0, 3);
                final isSelected = _tempDate.month == index + 1;
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, DateTime(_tempDate.year, index + 1));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFFE5E7EB),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      monthName,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF4B5563),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
