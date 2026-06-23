import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import 'home_header.dart';
import 'home_course_card.dart';
import 'home_quick_actions.dart';
import 'home_band_score_card.dart';
import 'home_live_class_card.dart';

class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 470,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5B35F5), Color(0xFF4224E8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34),
                    bottomRight: Radius.circular(34),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 38, 14, 0),
                child: Column(
                  children: [
                    HomeHeader(),
                    SizedBox(height: 26),
                    HomeCourseCard(),
                    SizedBox(height: 30),
                    HomeQuickActions(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 58),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                AppScrollReveal(child: HomeBandScoreCard()),
                SizedBox(height: 22),
                AppScrollReveal(child: HomeLiveClassCard()),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
