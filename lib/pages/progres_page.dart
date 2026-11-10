import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../data/bug_note_data.dart';
import '../models/bug_note.dart';
import '../models/learning_module.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/category_pills.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/progress/bug_note_card.dart';
import '../widgets/progress/progress_stat_grid.dart';
import '../widgets/progress/student_profile_card.dart';
import '../widgets/progress/weekly_activity_card.dart';
import 'login_page.dart';

const List<CategoryPill> _kBugFilterPills = [
  CategoryPill(label: 'Semua Catatan', value: 'all'),
  CategoryPill(label: 'HTML', value: 'html'),
  CategoryPill(label: 'CSS', value: 'css'),
  CategoryPill(label: 'JavaScript/Dasar', value: 'js'),
];

/// Halaman Progres (tab index 3). Diambil dari fixpls/progress_page.dart
/// (HTML), dipecah jadi widget reusable di widgets/progress/.
class ProgresPage extends StatefulWidget {
  const ProgresPage({super.key});

  @override
  State<ProgresPage> createState() => _ProgresPageState();
}

class _ProgresPageState extends State<ProgresPage> {
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    UserProfile.instance.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    UserProfile.instance.removeListener(_onProfileChanged);
    super.dispose();
  }

  List<BugNote> get _filteredNotes {
    if (_selectedFilter == 'all') return kBugNotes;
    return kBugNotes.where((n) => n.category == _selectedFilter).toList();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.slate900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        margin: const EdgeInsets.only(bottom: 80, left: 40, right: 40),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar Akun?'),
        content: const Text('Kamu perlu login ulang untuk mengakses DebugTIK lagi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await AuthService.logout();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;

    return MainScaffold(
      currentIndex: 3,
      headerSubtitle: 'Progres Belajar',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          StudentProfileCard(
            studentName: UserProfile.instance.name,
            studentEmail: UserProfile.instance.email,
            avatar: UserProfile.instance.avatar,
          ),
          const SizedBox(height: 14),
          const ProgressStatGrid(),
          const SizedBox(height: 14),
          const WeeklyActivityCard(),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.auto_stories, size: 18, color: AppColors.sky600),
                  SizedBox(width: 8),
                  Text('Buku Catatan Bug', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.slate900)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.slate200)),
                child: Text('${kBugNotes.length} Catatan', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.slate600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CategoryPills(
            selectedValue: _selectedFilter,
            onSelected: (v) => setState(() => _selectedFilter = v),
            pills: _kBugFilterPills,
          ),
          const SizedBox(height: 12),
          if (notes.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('Belum ada catatan bug untuk kategori ini.', style: TextStyle(color: AppColors.slate500, fontSize: 13))),
            )
          else
            ...notes.map((n) => Padding(padding: const EdgeInsets.only(bottom: 12), child: BugNoteCard(note: n))),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => _showToast('Membuka formulir catatan bug baru...'),
              icon: const Icon(Icons.add_circle, size: 20),
              label: const Text('Tambah Catatan Bug Baru', style: TextStyle(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.sky600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showToast('Menyiapkan Rekap Nilai & Debug TIK (PDF)...'),
              icon: const Icon(Icons.picture_as_pdf, size: 20, color: Color(0xFFF43F5E)),
              label: const Text('Unduh Rekap Tugas TIK (PDF)', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.slate700)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.slate300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton.icon(
              onPressed: _confirmLogout,
              icon: const Icon(Icons.logout, size: 18, color: Colors.red),
              label: const Text('Keluar Akun', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
