import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../widgets/month_picker_dialog.dart';
import '../widgets/attendance_summary_card.dart';
import '../widgets/attendance_calendar_card.dart';
import '../widgets/attendance_alert_box.dart';

class AttendancePage extends StatefulWidget {
  final bool isTab;
  const AttendancePage({super.key, this.isTab = false});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _selectedMonth = DateTime(2026, 2);

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

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await MonthPickerDialog.show(
      context,
      _selectedMonth,
    );
    if (picked != null) {
      setState(() {
        _selectedMonth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Calculate days in month and start day offset (Sunday is 0)
    final int daysInMonth = DateUtils.getDaysInMonth(
      _selectedMonth.year,
      _selectedMonth.month,
    );
    final int offset =
        DateTime(_selectedMonth.year, _selectedMonth.month, 1).weekday % 7;

    // 2. Generate calendar days and count stats
    int presentCount = 0;
    int absentCount = 0;

    final List<Map<String, dynamic>> calendarDays = List.generate(daysInMonth, (
      i,
    ) {
      final day = i + 1;
      final date = DateTime(_selectedMonth.year, _selectedMonth.month, day);
      final weekday = date.weekday;

      String status;
      if (weekday == DateTime.thursday || weekday == DateTime.friday) {
        status = 'holiday';
      } else if (day == 3 || day == 10 || day == 24) {
        status = 'absent';
        absentCount++;
      } else {
        status = 'present';
        presentCount++;
      }

      return {'day': day.toString(), 'status': status};
    });

    final int totalActiveCount = presentCount + absentCount;
    final int attendancePercentage = totalActiveCount > 0
        ? (presentCount / totalActiveCount * 100).round()
        : 0;

    final String formattedMonth =
        '${_months[_selectedMonth.month - 1]} ${_selectedMonth.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Curved Gradient Header Background
            Container(
              padding: const EdgeInsets.fromLTRB(
                17,
                42,
                17,
                160,
              ), // Increased bottom padding for overlap
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5B35F5), Color(0xFFB80DF5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 29,
                        ),
                        onPressed: () {
                          if (widget.isTab) {
                            DashboardPage.of(context)?.changeTab(0);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        'Attendance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),
                  Container(
                    height: 112,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(19, 20, 18, 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.15),
                          Colors.white.withValues(alpha: 0.09),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedMonth,
                                style: const TextStyle(
                                  color: Color(0xFFE7D7FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              AppAnimatedNumber(
                                value: attendancePercentage.toDouble(),
                                suffix: '%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 74,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Scrolling Content overlapping the header
            Transform.translate(
              offset: const Offset(
                0,
                -135,
              ), // Shifting up to overlap the header nicely
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    AttendanceSummaryCard(
                      present: presentCount,
                      absent: absentCount,
                      total: totalActiveCount,
                      percentage: attendancePercentage,
                    ),
                    const SizedBox(height: 20),
                    AppScrollReveal(
                      child: AttendanceCalendarCard(
                        calendarDays: calendarDays,
                        offset: offset,
                        daysInMonth: daysInMonth,
                        formattedMonth: formattedMonth,
                        onChangeMonth: () => _selectMonth(context),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppScrollReveal(
                      child: AttendanceAlertBox(absentCount: absentCount),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Downloading attendance report for $formattedMonth...',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Download Report',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
