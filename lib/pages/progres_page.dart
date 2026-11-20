import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../data/bug_note_data.dart';
import '../models/bug_note.dart';
import '../models/learning_module.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/category_pills.dart';
import '../widgets/glass_morphism_box.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/progress/bug_note_card.dart';
import '../widgets/progress/progress_stat_grid.dart';
import '../widgets/progress/student_profile_card.dart';
import '../widgets/progress/weekly_activity_card.dart';
import 'login_page.dart';

List<CategoryPill> _kBugFilterPills = [
  CategoryPill(label: 'Semua', value: 'all'),
  CategoryPill(label: 'HTML', value: 'html'),
  CategoryPill(label: 'CSS', value: 'css'),
  CategoryPill(label: 'JS/Dasar', value: 'js'),
];

class ProgresPage extends StatefulWidget {
  ProgresPage({super.key});

  @override
  State<ProgresPage> createState() => _ProgresPageState();
}

class _ProgresPageState extends State<ProgresPage>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'all';
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });

    UserProfile.instance.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _entranceController.dispose();
    UserProfile.instance.removeListener(_onProfileChanged);
    super.dispose();
  }

  /// Animasi geser bergiliran ringan (GPU-friendly) senada dengan HomePage.
  Widget _staggerSlide({
    required double start,
    required double end,
    required Widget child,
    double slideDistance = 72.0,
  }) {
    final curve = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(
        start.clamp(0.0, 0.90),
        end.clamp(0.10, 1.0),
        curve: Curves.easeOutQuart,
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: curve,
        child: child,
        builder: (context, cachedChild) {
          final offsetX = (1.0 - curve.value) * slideDistance;
          return Transform.translate(
            offset: Offset(offsetX, 0),
            child: cachedChild,
          );
        },
      ),
    );
  }

  List<BugNote> get _filteredNotes {
    if (_selectedFilter == 'all') return kBugNotes;
    return kBugNotes.where((n) => n.category == _selectedFilter).toList();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.slate900.withOpacity(0.92),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        margin: EdgeInsets.only(bottom: 96, left: 20, right: 20),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Batal Keluar',
      barrierColor: AppColors.slate900.withOpacity(0.28),
      transitionDuration: Duration(milliseconds: 240),
      pageBuilder: (dialogContext, _, __) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350),
              child: Material(
                color: Colors.transparent,
                child: GlassMorphismBox(
                  borderRadius: 28,
                  opacity: 0.72,
                  blurSigma: 8,
                  enableBlur: true,
                  padding: EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F2),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFECDD3)),
                        ),
                        child: Icon(
                          Icons.logout_rounded,
                          color: const Color(0xFFE11D48),
                          size: 22,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Keluar Akun?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.slate900,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Kamu perlu login ulang untuk mengakses DebugTIK lagi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.slate600,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.6),
                                foregroundColor: AppColors.slate700,
                                side:
                                    BorderSide(color: AppColors.slate300),
                                padding:
                                    EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                'Batal',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE11D48),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding:
                                    EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                'Keluar',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.90, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );

    if (confirmed != true) return;

    await AuthService.logout();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;
    final bottomSpace = MediaQuery.of(context).padding.bottom + 108;

    return MainScaffold(
      currentIndex: 3,
      headerSubtitle: 'Progres Belajar',
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomSpace),
        children: [
          _staggerSlide(
            start: 0.00,
            end: 0.42,
            slideDistance: 60,
            child: StudentProfileCard(
              studentName: UserProfile.instance.name,
              studentEmail: UserProfile.instance.email,
              avatar: UserProfile.instance.avatar,
            ),
          ),
          SizedBox(height: 12),
          _staggerSlide(
            start: 0.07,
            end: 0.48,
            slideDistance: 72,
            child: ProgressStatGrid(),
          ),
          SizedBox(height: 12),
          _staggerSlide(
            start: 0.14,
            end: 0.56,
            slideDistance: 84,
            child: WeeklyActivityCard(),
          ),
          SizedBox(height: 20),
          _staggerSlide(
            start: 0.21,
            end: 0.64,
            slideDistance: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Catatan Bug',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.slate900,
                            ),
                          ),
                          SizedBox(width: 8),
                          GlassMorphismBox(
                            borderRadius: 999,
                            opacity: 0.58,
                            padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 2),
                            boxShadow: [],
                            child: Text(
                              '${kBugNotes.length}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.sky600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () =>
                            _showToast('Membuka formulir catatan bug baru...'),
                        child: GlassMorphismBox(
                          borderRadius: 999,
                          opacity: 0.58,
                          padding:
                              EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                          boxShadow: [],
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_rounded,
                                  size: 16, color: AppColors.sky600),
                              SizedBox(width: 4),
                              Text(
                                'Tambah',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.sky700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CategoryPills(
                  selectedValue: _selectedFilter,
                  onSelected: (v) => setState(() => _selectedFilter = v),
                  pills: _kBugFilterPills,
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          if (notes.isEmpty)
            _staggerSlide(
              start: 0.28,
              end: 0.74,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28),
                child: Center(
                  child: Text(
                    'Belum ada catatan bug di kategori ini.',
                    style: TextStyle(color: AppColors.slate500, fontSize: 13),
                  ),
                ),
              ),
            )
          else
            ...List.generate(notes.length, (index) {
              final start = (0.28 + index * 0.08).clamp(0.0, 0.62);
              final end = (start + 0.36).clamp(0.36, 1.0);

              return _staggerSlide(
                start: start,
                end: end,
                slideDistance: 105,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: BugNoteCard(note: notes[index]),
                ),
              );
            }),
          SizedBox(height: 8),
          _staggerSlide(
            start: 0.50,
            end: 0.94,
            slideDistance: 92,
            child: GestureDetector(
              onTap: () => _showToast('Menyiapkan Rekap Tugas TIK (PDF)...'),
              child: GlassMorphismBox(
                borderRadius: 999,
                opacity: 0.56,
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded,
                        size: 19, color: AppColors.sky600),
                    SizedBox(width: 8),
                    Text(
                      'Unduh Rekap Progres (PDF)',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          _staggerSlide(
            start: 0.58,
            end: 1.00,
            slideDistance: 84,
            child: Center(
              child: GestureDetector(
                onTap: _confirmLogout,
                child: GlassMorphismBox(
                  borderRadius: 999,
                  opacity: 0.52,
                  tintColor: const Color(0xFFFFF1F2),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                  boxShadow: [],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout_rounded,
                          size: 16, color: const Color(0xFFE11D48)),
                      SizedBox(width: 6),
                      Text(
                        'Keluar Akun',
                        style: TextStyle(
                          color: const Color(0xFFE11D48),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}