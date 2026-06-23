import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../pages/dashboard_page.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _quickAction(
          Icons.menu_book_outlined,
          'Mock\nTest',
          const Color(0xFFA855F7),
          () => Navigator.pushNamed(context, AppRoutes.mockTestsList),
        ),
        _quickAction(Icons.access_time, 'Library', const Color(0xFF3B82F6), () {
          DashboardPage.of(context)?.changeTab(2);
        }),
        _quickAction(
          Icons.trending_up,
          'Progress',
          const Color(0xFF22C55E),
          () {
            DashboardPage.of(context)?.changeTab(1);
          },
        ),
        _quickAction(
          Icons.shopping_cart_outlined,
          'Buy\nMock',
          const Color(0xFFF97316),
          () => Navigator.pushNamed(context, AppRoutes.mockTestPurchase),
        ),
      ],
    );
  }

  Widget _quickAction(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 118,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
