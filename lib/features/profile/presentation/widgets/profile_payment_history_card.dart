import 'package:flutter/material.dart';

class ProfilePaymentItem {
  final String title;
  final String date;
  final String amount;
  final bool isGreen;

  const ProfilePaymentItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.isGreen,
  });
}

class ProfilePaymentHistoryCard extends StatelessWidget {
  final List<ProfilePaymentItem> payments;

  const ProfilePaymentHistoryCard({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Payment History',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.credit_card_outlined,
                color: Color(0xFF4F39F6),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: payments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentRow(payment);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(ProfilePaymentItem payment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: payment.isGreen
            ? const Color(0xFFD9FBE6)
            : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  payment.date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            payment.amount,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: payment.isGreen
                  ? const Color(0xFF079344)
                  : const Color(0xFF4B5563),
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
