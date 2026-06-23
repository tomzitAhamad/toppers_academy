import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/weekly_performance_chart.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

class CourseDetailsPage extends StatefulWidget {
  final bool isTab;
  const CourseDetailsPage({super.key, this.isTab = false});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. Curved Gradient Header Background
            Container(
              padding: const EdgeInsets.fromLTRB(
                6,
                44,
                14,
                54,
              ), // Extra bottom padding for overlap
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      if (widget.isTab) {
                        // Switch back to Home tab (Index 0)
                        DashboardPage.of(context)?.changeTab(0);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'IELTS Complete Course',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Batch: Morning A1',
                        style: TextStyle(
                          color: Color(0xFFD9D6FF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Scrolling Content overlapping the header
            Transform.translate(
              offset: const Offset(0, -32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Overall Progress Card
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shadowColor: Colors.black.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 0.68),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOutQuart,
                          builder: (context, value, child) {
                            final currentPercentage = (value * 100).toInt();
                            final currentCompleted = (88 * value).round();
                            final remaining = 88 - currentCompleted;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Overall Progress',
                                          style: TextStyle(
                                            color: Color(0xFF6B7280),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '$currentPercentage%',
                                          style: const TextStyle(
                                            color: Color(0xFF4F46FF),
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF8B5CF6),
                                            Color(0xFF7C3AED),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.trending_up,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: value,
                                    minHeight: 8,
                                    backgroundColor: const Color(0xFFE4E6FF),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF4F46FF),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$currentCompleted of 88 lessons completed',
                                      style: const TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '$remaining remaining',
                                      style: const TextStyle(
                                        color: Color(0xFF9CA3AF),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Batch Seat Status Card (Orange Gradient)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF97316), Color(0xFFFDBA74)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFF97316,
                            ).withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.groups_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Batch Seat Status',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 22.0),
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeOutQuart,
                            builder: (context, value, child) {
                              final enrolled = value.round();
                              final remaining = 30 - enrolled;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$enrolled/30',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        '$remaining\nSeats Left',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Students Enrolled',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: value / 30.0,
                                      minHeight: 6,
                                      backgroundColor: Colors.white24,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Weekly Performance Card
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shadowColor: Colors.black.withValues(alpha: 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.insights, color: Color(0xFF4F46FF)),
                                SizedBox(width: 8),
                                Text(
                                  'Weekly Performance',
                                  style: TextStyle(
                                    color: Color(0xFF111827),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const WeeklyPerformanceChart(),
                            const SizedBox(height: 10),
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 70.0),
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeOutQuart,
                              builder: (context, value, child) {
                                return RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF4B5563),
                                    ),
                                    children: [
                                      const TextSpan(text: 'Average Score: '),
                                      TextSpan(
                                        text: '${value.round()}%',
                                        style: const TextStyle(
                                          color: Color(0xFF4F46FF),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subject Progress Items (All using book icon matching mockup)
                    _buildSubjectProgressItem(
                      title: 'Listening',
                      completed: 18,
                      total: 24,
                      percentage: 0.75,
                    ),
                    _buildSubjectProgressItem(
                      title: 'Reading',
                      completed: 17,
                      total: 28,
                      percentage: 0.60,
                    ),
                    _buildSubjectProgressItem(
                      title: 'Writing',
                      completed: 9,
                      total: 20,
                      percentage: 0.45,
                    ),
                    _buildSubjectProgressItem(
                      title: 'Speaking',
                      completed: 13,
                      total: 16,
                      percentage: 0.80,
                    ),
                    const SizedBox(height: 18),

                    // Bottom Action Row
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu_book_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: const Text(
                                'Continue Learning',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46FF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Downloading course contents...'),
                              ),
                            );
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFD1D5DB),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.download_outlined,
                              color: Color(0xFF111827),
                              size: 22,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSubjectProgressItem({
    required String title,
    required int completed,
    required int total,
    required double percentage,
  }) {
    return AppScrollReveal(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: percentage),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutQuart,
        builder: (context, value, child) {
          final currentCompleted = percentage > 0.0
              ? (completed * (value / percentage)).round()
              : 0;
          final currentPercentage = (value * 100).toInt();

          return Card(
            elevation: 0.5,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEF2F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu_book_outlined,
                          color: Color(0xFF4F46FF),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFF1F2937),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$currentCompleted/$total lessons',
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$currentPercentage%',
                        style: const TextStyle(
                          color: Color(0xFF4F46FF),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFE4E6FF),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF4F46FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
