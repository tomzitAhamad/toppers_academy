import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/routes/app_routes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _payInInstallments = false;
  int _selectedMethodIndex = 0; // 0: Card, 1: Mobile Banking, 2: Digital Wallet
  bool _isProcessing = false;
  Timer? _processingTimer;

  @override
  void dispose() {
    _processingTimer?.cancel();
    super.dispose();
  }

  void _startPaymentProcess(String title, double price) {
    setState(() {
      _isProcessing = true;
    });

    _processingTimer?.cancel();
    _processingTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        Navigator.pushNamed(
          context,
          AppRoutes.paymentSuccess,
          arguments: {'title': title, 'price': price},
        );
      }
    });
  }

  String _formatCurrency(double val) {
    // 12000 -> 12,000
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return val.toInt().toString().replaceAllMapped(
      reg,
      (Match match) => '${match[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
            as Map<String, dynamic>;
    final title = arguments['title'] as String? ?? 'IELTS Complete Course';
    final price = arguments['price'] as double? ?? 12000.0;
    final description =
        arguments['description'] as String? ?? 'Duration: 3 Months';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF365DFF), // Vibrant Blue
            Color(0xFF7C3AED), // Indigo/Purple
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
            'Payment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Stack(
          children: [
            // Body Content
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
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
                  // Summary Card
                  AppScrollReveal(
                    child: _buildSummaryCard(title, price, description),
                  ),
                  const SizedBox(height: 16),

                  // Installments Card
                  AppScrollReveal(child: _buildInstallmentsCard()),
                  const SizedBox(height: 16),

                  // Payment Method Card
                  AppScrollReveal(child: _buildPaymentMethodCard(title, price)),
                  const SizedBox(height: 80), // extra padding for bottom loader
                ],
              ),
            ),

            // Timed Proceeding to payment dialog sheet
            if (_isProcessing) _buildProcessingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double price, String description) {
    final formattedPrice = _formatCurrency(price);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title == 'IELTS Complete Course'
                ? 'Course Summary'
                : 'Mock Test Summary',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF334155),
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
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
                  ],
                ),
              ),
              Text(
                '৳$formattedPrice',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '৳$formattedPrice',
                style: const TextStyle(
                  color: Color(0xFF4F46FF),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            color: Color(0xFF4F46FF),
            size: 20,
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Pay in Installments',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Switch(
            value: _payInInstallments,
            onChanged: (val) {
              setState(() {
                _payInInstallments = val;
              });
            },
            activeThumbColor: const Color(0xFF4F46FF),
            activeTrackColor: const Color(0xFFEEF2F6),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFCBD5E1),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String title, double price) {
    final formattedPrice = _formatCurrency(price);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.attach_money, color: Color(0xFF4F46FF), size: 22),
              SizedBox(width: 8),
              Text(
                'Payment Method',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Methods selection
          _methodRow(
            index: 0,
            icon: Icons.credit_card,
            label: 'Credit/Debit Card',
          ),
          const SizedBox(height: 12),
          _methodRow(
            index: 1,
            icon: Icons.phone_android,
            label: 'Mobile Banking',
          ),
          const SizedBox(height: 12),
          _methodRow(
            index: 2,
            icon: Icons.account_balance_wallet_outlined,
            label: 'Digital Wallet',
          ),
          const SizedBox(height: 24),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => _startPaymentProcess(title, price),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Pay ৳$formattedPrice Now',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Color(0xFF10B981),
                size: 14,
              ),
              SizedBox(width: 6),
              Text(
                'Secure payment powered by SSL',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _methodRow({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedMethodIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethodIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEEF2F6).withValues(alpha: 0.5)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4F46FF)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF4F46FF)
                  : const Color(0xFF64748B),
              size: 20,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4F46FF),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Proceeding to payment...',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  onPressed: () {
                    setState(() {
                      _isProcessing = false;
                    });
                    _processingTimer?.cancel();
                  },
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
