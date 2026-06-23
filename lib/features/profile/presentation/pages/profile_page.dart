import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../widgets/profile_band_card.dart';
import '../widgets/profile_personal_info_card.dart';
import '../widgets/profile_enrollment_card.dart';
import '../widgets/profile_payment_history_card.dart';
import '../widgets/profile_mock_test_history_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Stack (Gradient header + overlapping band score cards)
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 290,
                  width: double.infinity,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 38, 14, 0),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () {
                              // Switch back to Home tab (Index 0)
                              DashboardPage.of(context)?.changeTab(0);
                            },
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Edit profile feature coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Avatar
                      Container(
                        width: 86,
                        height: 86,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF4F39F6),
                          size: 52,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // User Info
                      const Text(
                        'Nafiz Rahman',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'ID: TA2026-001',
                        style: TextStyle(
                          color: Color(0xFFE7D7FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 26),
                      // Overlapping Band Score Cards Row
                      Row(
                        children: const [
                          Expanded(
                            child: ProfileBandCard(
                              title: 'Current Band',
                              score: '7.5',
                              iconColor: Color(0xFF4F39F6),
                              bgColor: Color(0xFFEEF2F6),
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: ProfileBandCard(
                              title: 'Target Band',
                              score: '8.0',
                              iconColor: Color(0xFF10B981),
                              bgColor: Color(0xFFD1FAE5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64), // Spacing for the overlapping cards
            // 2. Personal, Enrollment, Payment, Mock details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const AppScrollReveal(
                    child: ProfilePersonalInfoCard(
                      email: 'nafiz.rahman@example.com',
                      phone: '+880 1712-345678',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppScrollReveal(
                    child: ProfileEnrollmentCard(
                      course: 'IELTS Complete Course',
                      batch: 'Morning A1',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppScrollReveal(
                    child: ProfilePaymentHistoryCard(
                      payments: [
                        ProfilePaymentItem(
                          title: 'Course Fee - Installment 1',
                          date: 'Mar 1, 2026',
                          amount: '৳4,000',
                          isGreen: true,
                        ),
                        ProfilePaymentItem(
                          title: 'Registration Fee',
                          date: 'Feb 1, 2026',
                          amount: '৳500',
                          isGreen: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppScrollReveal(
                    child: ProfileMockTestHistoryCard(
                      items: [
                        ProfileMockTestItem(
                          title: 'Mock Test #1',
                          date: 'Feb 15, 2026',
                          score: '7.5',
                        ),
                        ProfileMockTestItem(
                          title: 'Mock Test #2',
                          date: 'Feb 20, 2026',
                          score: '8',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Settings Button
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings tapped')),
                      );
                    },
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Color(0xFF4B5563),
                      size: 18,
                    ),
                    label: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Logout Button
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/sign-in',
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Color(0xFFEF4444),
                      size: 18,
                    ),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFFEF4444),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
