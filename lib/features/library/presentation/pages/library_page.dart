import 'package:flutter/material.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

class LibraryPage extends StatefulWidget {
  final bool isTab;
  const LibraryPage({super.key, this.isTab = false});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, bool> _downloadingState = {};
  final Map<String, bool> _downloadedState = {};
  int _activeTabIndex = 0;
  int _animationVersion = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_activeTabIndex == _tabController.index) return;

    setState(() {
      _activeTabIndex = _tabController.index;
      _animationVersion++;
    });
  }

  void _handleDownload(String title) async {
    if (_downloadedState[title] == true || _downloadingState[title] == true) {
      return;
    }

    setState(() {
      _downloadingState[title] = true;
    });

    // Simulate download delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _downloadingState[title] = false;
        _downloadedState[title] = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title downloaded successfully!'),
          backgroundColor: AppColors.activeGreen,
        ),
      );
    }
  }

  void _showPremiumModal(String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.goldLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: AppColors.goldDark,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Unlock Premium Feature',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Get full access to "$title" and unlock all templates, mock classes, and practice materials.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textMedium,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Subscription requested! Processing details...',
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Upgrade for \$9.99/mo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Maybe Later',
                  style: TextStyle(color: AppColors.textMedium),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              primary: true,
              elevation: 0,
              backgroundColor: const Color(0xFFF5F6FA),
              expandedHeight: 146.0 + statusBarHeight,
              toolbarHeight: 0,
              collapsedHeight: 72.0 + statusBarHeight,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double currentHeight = constraints.maxHeight;
                  final double minH = 72.0 + statusBarHeight;
                  final double maxH = 146.0 + statusBarHeight;
                  final double t = ((currentHeight - minH) / (maxH - minH))
                      .clamp(0.0, 1.0);

                  return Stack(
                    children: [
                      // Gradient header container
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: currentHeight,
                        child: Opacity(
                          opacity: t,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 118.0 + statusBarHeight,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                  6,
                                  statusBarHeight + 8,
                                  14,
                                  0,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          DashboardPage.of(
                                            context,
                                          )?.changeTab(0);
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Library',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: Container(
                  color: const Color(0xFFF5F6FA),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xFF8A94A6),
                      tabs: const [
                        Tab(icon: Icon(Icons.article_outlined, size: 22)),
                        Tab(icon: Icon(Icons.headphones_outlined, size: 22)),
                        Tab(icon: Icon(Icons.videocam_outlined, size: 22)),
                        Tab(icon: Icon(Icons.class_outlined, size: 22)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // PDF Tab View
            ListView(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 12,
                bottom: 16,
              ),
              children: [
                _buildAnimatedLibraryItem(
                  tabIndex: 0,
                  itemIndex: 0,
                  title: 'IELTS Writing Task\n2 Templates',
                  meta: '2.5 MB',
                  icon: Icons.description_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 0,
                  itemIndex: 1,
                  title: 'Academic Reading\nStrategies',
                  meta: '3.2 MB',
                  icon: Icons.description_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 0,
                  itemIndex: 2,
                  title: 'Speaking Cue\nCards Collection',
                  meta: '3.2 MB',
                  icon: Icons.description_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 0,
                  itemIndex: 3,
                  title: 'Grammar Essential Guide',
                  meta: '4.1 MB',
                  icon: Icons.lock_outline,
                  color: const Color(0xFF8A94A6),
                  isLocked: true,
                ),
              ],
            ),

            // Audio Tab View
            ListView(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 12,
                bottom: 16,
              ),
              children: [
                _buildAnimatedLibraryItem(
                  tabIndex: 1,
                  itemIndex: 0,
                  title: 'Listening Practice - Part 1',
                  meta: '12:45',
                  icon: Icons.headphones_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 1,
                  itemIndex: 1,
                  title: 'British Accent Practice',
                  meta: '8:30',
                  icon: Icons.headphones_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 1,
                  itemIndex: 2,
                  title: 'American Accent Practice',
                  meta: '9:15',
                  icon: Icons.lock_outline,
                  color: const Color(0xFF8A94A6),
                  isLocked: true,
                ),
              ],
            ),

            // Video Tab View
            ListView(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 12,
                bottom: 16,
              ),
              children: [
                _buildAnimatedLibraryItem(
                  tabIndex: 2,
                  itemIndex: 0,
                  title: 'Writing Task 1 - Line Graph',
                  meta: '25:30',
                  icon: Icons.videocam_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 2,
                  itemIndex: 1,
                  title: 'Speaking Part 2 Tips',
                  meta: '18:45',
                  icon: Icons.videocam_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 2,
                  itemIndex: 2,
                  title: 'Reading Speed Techniques',
                  meta: '22:10',
                  icon: Icons.lock_outline,
                  color: const Color(0xFF8A94A6),
                  isLocked: true,
                ),
              ],
            ),

            // Bookmarks / Vocabulary Tab View
            ListView(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 12,
                bottom: 16,
              ),
              children: [
                _buildAnimatedLibraryItem(
                  tabIndex: 3,
                  itemIndex: 0,
                  title: 'Academic Vocabulary -\nSet 1',
                  meta: '50 words',
                  icon: Icons.class_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 3,
                  itemIndex: 1,
                  title: 'IELTS Band 7+ Words',
                  meta: '75 words',
                  icon: Icons.class_outlined,
                  color: AppColors.primary,
                ),
                _buildAnimatedLibraryItem(
                  tabIndex: 3,
                  itemIndex: 2,
                  title: 'Idioms and Phrases',
                  meta: '100 words',
                  icon: Icons.lock_outline,
                  color: const Color(0xFF8A94A6),
                  isLocked: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLibraryItem({
    required int tabIndex,
    required int itemIndex,
    required String title,
    required String meta,
    required IconData icon,
    required Color color,
    bool isLocked = false,
  }) {
    final card = _buildLibraryItem(
      title: title,
      meta: meta,
      icon: icon,
      color: color,
      isLocked: isLocked,
    );

    return AppReveal(
      key: ValueKey('library-$tabIndex-$_animationVersion-$title'),
      delay: Duration(milliseconds: 85 * itemIndex),
      duration: const Duration(milliseconds: 500),
      offset: const Offset(0, 0.08),
      beginScale: 0.98,
      beginOpacity: 0,
      child: card,
    );
  }

  Widget _buildLibraryItem({
    required String title,
    required String meta,
    required IconData icon,
    required Color color,
    bool isLocked = false,
  }) {
    final isDownloading = _downloadingState[title] == true;
    final isDownloaded = _downloadedState[title] == true;

    return Card(
      elevation: 0.5,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isLocked
                        ? const Color(0xFFF3F4F6)
                        : const Color(0xFFEEF2F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isLocked ? Icons.lock_outline : icon,
                    color: isLocked ? const Color(0xFF8A94A6) : color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isLocked
                              ? const Color(0xFF8A94A6)
                              : const Color(0xFF1F2937),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meta,
                        style: const TextStyle(
                          color: Color(0xFF8A94A6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (isLocked)
                  const SizedBox.shrink()
                else
                  GestureDetector(
                    onTap: () => _handleDownload(title),
                    child: isDownloaded
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.activeGreen,
                            size: 24,
                          )
                        : isDownloading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : const Icon(
                            Icons.download_outlined,
                            color: AppColors.primary,
                            size: 24,
                          ),
                  ),
              ],
            ),
          ),
          if (isLocked)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: GestureDetector(
                onTap: () => _showPremiumModal(title),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB), // Amber 50
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFFCD34D),
                    ), // Amber 300
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.lock,
                        color: Color(0xFFD97706), // Amber 600
                        size: 15,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Unlock with premium subscription',
                        style: TextStyle(
                          color: Color(0xFFD97706), // Amber 600
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
