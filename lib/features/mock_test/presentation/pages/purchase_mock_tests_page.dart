import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/routes/app_routes.dart';

class PurchaseMockTestsPage extends StatelessWidget {
  const PurchaseMockTestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF007A), // Hot Pink/Red
            Color(0xFFFF6B00), // Orange
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Purchase Extra Mock Tests',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Column(
          children: [
            // Header Promo content
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const Column(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Boost your preparation with additional mock tests and improve your band score',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFEE2E2),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Single Mock Test Card
                    AppScrollReveal(
                      child: _buildPackageCard(
                        context: context,
                        title: 'Single Mock Test',
                        price: 500,
                        description: '1 Mock Test',
                        features: [
                          'Full IELTS Mock Test',
                          'Instant Band Score',
                          'Teacher Feedback',
                          'Valid for 30 days',
                        ],
                        buttonColor: const Color(0xFF4F46FF),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mock Test Bundle Card (Most Popular)
                    AppScrollReveal(
                      child: _buildPopularPackageCard(
                        context: context,
                        title: 'Mock Test Bundle',
                        originalPrice: 2500,
                        price: 2000,
                        description: '5 Mock Tests',
                        features: [
                          '5 Full Mock Tests',
                          'Detailed Analytics',
                          'Priority Teacher Feedback',
                          'Valid for 90 days',
                        ],
                        buttonColor: const Color(0xFFEA580C),
                        savingAmount: 500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Ultimate Package Card
                    AppScrollReveal(
                      child: _buildPackageCard(
                        context: context,
                        title: 'Ultimate Package',
                        originalPrice: 5000,
                        price: 3500,
                        description: '10 Mock Tests',
                        features: [
                          '10 Full Mock Tests',
                          'Advanced Analytics',
                          '1-on-1 Counseling Session',
                          'Priority Support',
                          'Valid for 180 days',
                        ],
                        buttonColor: const Color(0xFF4F46FF),
                        savingAmount: 1500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Why purchase card
                    AppScrollReveal(child: _buildWhyPurchaseCard()),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required String title,
    required double price,
    double? originalPrice,
    required String description,
    required List<String> features,
    required Color buttonColor,
    double? savingAmount,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (originalPrice != null) ...[
                Text(
                  '৳${originalPrice.toInt()}',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                '৳${price.toInt()}',
                style: const TextStyle(
                  color: Color(0xFFEA580C),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          Column(
            children: features
                .map(
                  (feat) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF10B981),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feat,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.payment,
                  arguments: {
                    'title': title,
                    'price': price,
                    'description': description,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Purchase Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (savingAmount != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFA7F3D0)),
              ),
              child: Text(
                'Save ৳${savingAmount.toInt()}',
                style: const TextStyle(
                  color: Color(0xFF047857),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPopularPackageCard({
    required BuildContext context,
    required String title,
    required double originalPrice,
    required double price,
    required String description,
    required List<String> features,
    required Color buttonColor,
    required double savingAmount,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildPackageCard(
          context: context,
          title: title,
          price: price,
          originalPrice: originalPrice,
          description: description,
          features: features,
          buttonColor: buttonColor,
          savingAmount: savingAmount,
        ),
        Positioned(
          top: -12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF4D00), Color(0xFFFF007A)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF007A).withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 13),
                  SizedBox(width: 4),
                  Text(
                    'MOST POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWhyPurchaseCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why Purchase Extra Mock Tests?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          ...[
            'Practice in real exam conditions',
            'Identify your weak areas and improve',
            'Get detailed feedback from expert teachers',
            'Track your progress over time',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
