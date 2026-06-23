import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/routes/app_routes.dart';

class MockTestDetailsPage extends StatelessWidget {
  const MockTestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF365DFF), // Vibrant Blue
            Color(0xFF7A22F4), // Indigo/Purple
            Color(0xFFCD00E8), // Pink/Magenta
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _buildHeader(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 26, 26, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppScrollReveal(child: _buildMobileNotice()),
                          const SizedBox(height: 22),
                          _sectionTitle('Test Structure'),
                          const SizedBox(height: 14),
                          AppScrollReveal(child: _buildStructureGrid()),
                          const SizedBox(height: 22),
                          _sectionTitle('Important Instructions'),
                          const SizedBox(height: 14),
                          AppScrollReveal(child: _buildInstructions()),
                          const SizedBox(height: 22),
                          _sectionTitle('System Requirements'),
                          const SizedBox(height: 14),
                          AppScrollReveal(child: _buildRequirements()),
                          const SizedBox(height: 26),
                          AppScrollReveal(child: _buildButtons(context)),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              '💡 Tip: For the best experience, use\n'
                              'a desktop or laptop computer',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFEA580C),
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(40, 35, 40, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF365DFF), Color(0xFF7A22F4), Color(0xFFCD00E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mock Test #3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'IELTS Academic Format',
                    style: TextStyle(
                      color: Color(0xFFE6D8FF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 47,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 17),
                SizedBox(width: 10),
                Text(
                  'Total Duration: 2 hours\n45 minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF93C5FD)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.laptop, color: Color(0xFF2563EB), size: 14),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Device -\nTest Available',
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'You can take the test on mobile.\n'
                  'For best results, we recommend\n'
                  'using a desktop/laptop.',
                  style: TextStyle(
                    color: Color(0xFF2563EB),
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildStructureGrid() {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.32,
      children: [
        _structureCard(
          Icons.volume_up_outlined,
          'Listening',
          '30 minutes',
          '40 questions',
          const Color(0xFF3B82F6),
          const Color(0xFFDBEAFE),
        ),
        _structureCard(
          Icons.description_outlined,
          'Reading',
          '60 minutes',
          '40 questions',
          const Color(0xFF10B981),
          const Color(0xFFD1FAE5),
        ),
        _structureCard(
          Icons.description_outlined,
          'Writing',
          '60 minutes',
          '2 tasks',
          const Color(0xFFF97316),
          const Color(0xFFFFEDD5),
        ),
        _structureCard(
          Icons.mic_none_outlined,
          'Speaking',
          '15 minutes',
          '3 parts',
          const Color(0xFFA855F7),
          const Color(0xFFF3E8FF),
        ),
      ],
    );
  }

  Widget _structureCard(
    IconData icon,
    String title,
    String duration,
    String count,
    Color color,
    Color bg,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 15, 10, 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12,
                    height: 1.1,
                  ),
                ),
                const Spacer(),
                Text(
                  count,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    final items = [
      'Ensure you have a stable internet\nconnection throughout the test',
      'The test must be completed\nin one sitting - you cannot\npause and resume',
      'Each section has a specific time\nlimit that will be strictly enforced',
      'You can navigate between\nquestions within each section',
      'Your answers are automatically\nsaved as you progress',
      'Do not refresh the page or\nnavigate away during the test',
      'Ensure your device audio is\nworking for the Listening\nsection',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 9),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFACC15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.error_outline, color: Color(0xFFF97316), size: 19),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please read carefully\nbefore starting the\ntest',
                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          ...items.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFFF97316),
                    size: 15,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Color(0xFF92400E),
                        fontSize: 12,
                        height: 1.22,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildRequirements() {
    return Row(
      children: [
        Expanded(
          child: _requirementBox(Icons.laptop_mac, 'Desktop/Lap', 'Required'),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: _requirementBox(
            Icons.volume_up_outlined,
            'Audio',
            'Working\nspeak\ners',
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: _requirementBox(
            Icons.watch_later_outlined,
            'Time',
            '2h 45m\nuninterrup\nted',
          ),
        ),
      ],
    );
  }

  Widget _requirementBox(IconData icon, String label, String value) {
    return Container(
      height: 108,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF4F46E5), size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 12,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              height: 1.05,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 30,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Go Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.mockTestActive);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF742CF6),
                minimumSize: const Size(64, 30),
                maximumSize: const Size(double.infinity, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Start Test Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
