import 'package:flutter/material.dart';
import 'LabFix.dart';
import 'package:flutter/material.dart';

// ============================================================
// DebugTIK - Modul Pembelajaran (Home / Dashboard Screen)
// Konversi dari HTML/Tailwind ke Flutter
// ============================================================

void main() {
  runApp(const DebugTikApp());
}

class DebugTikApp extends StatelessWidget {
  const DebugTikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DebugTIK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.slate50,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.sky600),
      ),
      home: const HomeScreen(),
    );
  }
}

// ------------------------------------------------------------
// Color palette (mirrors Tailwind slate / sky / amber / emerald)
// ------------------------------------------------------------
class AppColors {
  static const sky600 = Color(0xFF0284C7);
  static const sky700 = Color(0xFF0369A1);
  static const sky50 = Color(0xFFF0F9FF);
  static const sky100 = Color(0xFFE0F2FE);
  static const sky200 = Color(0xFFBAE6FD);

  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);

  static const emerald50 = Color(0xFFECFDF5);
  static const emerald200 = Color(0xFFA7F3D0);
  static const emerald500 = Color(0xFF10B981);
  static const emerald700 = Color(0xFF047857);
  static const emerald950 = Color(0xFF022C22);

  static const amber50 = Color(0xFFFFFBEB);
  static const amber100 = Color(0xFFFEF3C7);
  static const amber200 = Color(0xFFFDE68A);
  static const amber300 = Color(0xFFFCD34D);
  static const amber700 = Color(0xFFB45309);
  static const amber800 = Color(0xFF92400E);
  static const amber900 = Color(0xFF78350F);

  static const orange50 = Color(0xFFFFF7ED);
  static const orange600 = Color(0xFFEA580C);
  static const orange100 = Color(0xFFFFEDD5);

  static const rose300 = Color(0xFFFDA4AF);
  static const rose400 = Color(0xFFFB7185);
}

// ------------------------------------------------------------
// Data models
// ------------------------------------------------------------
class LearningModule {
  final String code; // MOD-01
  final String idMateri; // MAT-01
  final String category; // html | css | js
  final String categoryLabel; // HTML DASAR
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color iconBorder;
  final String level; // Pemula
  final String duration; // 15 mnt
  final String title;
  final String description;
  final IconData bugIcon;
  final Color bugIconColor;
  final Color bugTextColor;
  final String bugSnippet;
  final String caseCount; // 6 Kasus
  final String quizCount; // KUIS_TIK: 4 Soal
  final String labCount; // LAB_PRAKTIK: 2 Sesi

  const LearningModule({
    required this.code,
    required this.idMateri,
    required this.category,
    required this.categoryLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.iconBorder,
    required this.level,
    required this.duration,
    required this.title,
    required this.description,
    required this.bugIcon,
    required this.bugIconColor,
    required this.bugTextColor,
    required this.bugSnippet,
    required this.caseCount,
    required this.quizCount,
    required this.labCount,
  });
}

final List<LearningModule> kModules = [
  LearningModule(
    code: 'MOD-01 • HTML DASAR',
    idMateri: 'id_materi: MAT-01',
    category: 'html',
    categoryLabel: 'HTML Dasar',
    icon: Icons.html_outlined,
    iconColor: AppColors.orange600,
    iconBg: AppColors.orange50,
    iconBorder: AppColors.orange100,
    level: 'Pemula',
    duration: '15 mnt',
    title: 'Mengenal Kerangka Web (Tag <h1>, <p>, <a>, <img>)',
    description:
        'Belajar struktur fondasi halaman web, menyusun heading judul, paragraf teks, tautan link, dan menampilkan gambar.',
    bugIcon: Icons.bug_report_outlined,
    bugIconColor: AppColors.rose400,
    bugTextColor: AppColors.rose300,
    bugSnippet: '<h1>Halo Dunia // lupa tag penutup </h1>',
    caseCount: '6 Kasus',
    quizCount: 'KUIS_TIK: 4 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
  LearningModule(
    code: 'MOD-02 • CSS DASAR',
    idMateri: 'id_materi: MAT-02',
    category: 'css',
    categoryLabel: 'CSS Dasar',
    icon: Icons.palette_outlined,
    iconColor: AppColors.sky600,
    iconBg: AppColors.sky50,
    iconBorder: AppColors.sky100,
    level: 'Pemula',
    duration: '20 mnt',
    title: 'Memberi Warna & Gaya Tampilan (Color, Font, Background)',
    description:
        'Mempercantik tampilan web sederhana dengan mengatur warna teks, ukuran font tulisan, serta latar belakang warna elemen.',
    bugIcon: Icons.warning_amber_outlined,
    bugIconColor: AppColors.amber300,
    bugTextColor: AppColors.amber300,
    bugSnippet: 'collor: red; // typo: seharusnya color: red;',
    caseCount: '5 Kasus',
    quizCount: 'KUIS_TIK: 5 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
  LearningModule(
    code: 'MOD-03 • JS DASAR',
    idMateri: 'id_materi: MAT-03',
    category: 'js',
    categoryLabel: 'JavaScript Dasar',
    icon: Icons.javascript_outlined,
    iconColor: AppColors.amber700,
    iconBg: AppColors.amber50,
    iconBorder: AppColors.amber100,
    level: 'Pemula',
    duration: '25 mnt',
    title: 'Interaksi Tombol Sederhana & alert()',
    description:
        'Membuat website menjadi interaktif dengan menangani klik tombol untuk memunculkan pesan pop-up alert sederhana bagi pengguna.',
    bugIcon: Icons.error_outline,
    bugIconColor: AppColors.rose400,
    bugTextColor: AppColors.rose300,
    bugSnippet: 'alert "Halo Siswa!" // SyntaxError: kurung hilang',
    caseCount: '7 Kasus',
    quizCount: 'KUIS_TIK: 5 Soal',
    labCount: 'LAB_PRAKTIK: 2 Sesi',
  ),
];

const kCategoryPills = [
  {'label': 'Semua', 'value': 'all'},
  {'label': 'HTML Dasar', 'value': 'html'},
  {'label': 'CSS Dasar', 'value': 'css'},
  {'label': 'JavaScript Dasar', 'value': 'js'},
];

// ------------------------------------------------------------
// Home Screen
// ------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  int _bottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  List<LearningModule> get _filteredModules {
    return kModules.where((m) {
      final matchCat = _selectedCategory == 'all' || m.category == _selectedCategory;
      final haystack =
          '${m.title} ${m.description} ${m.categoryLabel} ${m.bugSnippet}'.toLowerCase();
      final matchKeyword = _searchQuery.isEmpty || haystack.contains(_searchQuery.toLowerCase());
      return matchCat && matchKeyword;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 16),
                  _buildTeacherBanner(),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildActiveModuleCard(),
                  const SizedBox(height: 20),
                  _buildCategoryPills(),
                  const SizedBox(height: 14),
                  ..._buildModuleCards(),
                  const SizedBox(height: 8),
                  _buildTipsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------------- Header ----------------
  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(bottom: BorderSide(color: AppColors.slate200)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky600,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: AppColors.sky600.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(Icons.terminal, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'DebugTIK',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.slate900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.sky100,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'EduTIK',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.sky700,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Modul Pembelajaran',
                style: TextStyle(fontSize: 11, color: AppColors.slate500, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.slate600),
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.slate200,
                backgroundImage: const NetworkImage(
                  'https://lh3.googleusercontent.com/aida/AEtjO1UrPunaegfIutXi67dQ_V8EiUtXlmvw7asMO1r46nxFIA3vZVJa1g4rZRyRzI24M75oYmLihiHH6AP0Y_OtAHvpNGbVTH1Btr09STwP1Ql66hIOsmpra6qnz0yT2J_d9c7C4gBe082CONu4UBEDrcGk_mc-RXjjzfi7wEa4I0ILwYNB-1_qkePDbusjji-JtGX122ND0bsajKpRhHJ82GgDbAQ4mrZ0-Oo9tAbxUEZjWaZXiwYbBq8anEM',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.emerald500,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Greeting ----------------
  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text.rich(
              TextSpan(
                text: 'Halo, Alifia ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.slate900,
                  letterSpacing: -0.3,
                ),
                children: [TextSpan(text: '👋')],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.emerald200.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.emerald500, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Live Sync',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.emerald700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.school, size: 16, color: AppColors.sky600),
            SizedBox(width: 6),
            Text(
              'Kelas XI TIK 2 • Pemrograman Web & Logika',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.slate600),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- Teacher banner ----------------
  Widget _buildTeacherBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200.withOpacity(0.8)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.sky100),
            ),
            child: const Icon(Icons.badge_outlined, color: AppColors.sky600, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    const Text(
                      'Bpk. Hendra Pratama, S.Kom',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.slate900),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'id_guru: GRU-01',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 11, color: AppColors.slate500),
                    children: [
                      TextSpan(text: 'hendra.guru@sekolah.sch.id • '),
                      TextSpan(
                        text: 'GURU mengelola 6 MATERI_BELAJAR',
                        style: TextStyle(color: AppColors.sky700, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Search bar ----------------
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate300),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.manage_search, color: AppColors.sky600, size: 20),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.trim()),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari materi, jenis bug, sintaks (TypeError, loop)...',
                hintStyle: TextStyle(color: AppColors.slate400, fontSize: 13),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
              style: const TextStyle(fontSize: 13, color: AppColors.slate800),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 6),
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.tune, size: 18, color: AppColors.slate600),
          ),
        ],
      ),
    );
  }

  // ---------------- Active module card ----------------
  Widget _buildActiveModuleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.sky50, Colors.white, Color(0xFFEFF6FF)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.sky200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: AppColors.sky600, borderRadius: BorderRadius.circular(999)),
                child: const Text(
                  'MODUL AKTIF',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.amber100.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.timer_outlined, size: 15, color: AppColors.amber700),
                    SizedBox(width: 4),
                    Text(
                      'Sisa ~25 Mnt',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.amber700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Modul 01: Mengenal Tag Dasar HTML & Kerangka Web',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.slate900),
          ),
          const SizedBox(height: 4),
          const Text(
            'Unit 1: Mengenal Struktur Kerangka Web, Tag <h1>, <p>, <a>, dan <img>',
            style: TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Penyelesaian Modul',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.slate600)),
              Text('68%',
                  style: TextStyle(
                      fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.sky700)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 8,
              backgroundColor: AppColors.slate200.withOpacity(0.8),
              valueColor: const AlwaysStoppedAnimation(AppColors.sky600),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sky600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Lanjut Belajar', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: const Icon(Icons.bookmark, color: AppColors.slate600, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Category pills ----------------
  Widget _buildCategoryPills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'KATEGORI MATERI',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '4 Kategori',
              style: TextStyle(
                  fontFamily: 'monospace', fontSize: 12, color: AppColors.sky700, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: kCategoryPills.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final pill = kCategoryPills[index];
              final isActive = _selectedCategory == pill['value'];
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = pill['value']!),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.sky600 : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: isActive ? null : Border.all(color: AppColors.slate200),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 3)],
                  ),
                  child: Text(
                    pill['label']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.slate700,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- Module cards ----------------
  List<Widget> _buildModuleCards() {
    final modules = _filteredModules;
    if (modules.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text('Tidak ada modul ditemukan', style: TextStyle(color: AppColors.slate500, fontSize: 13)),
          ),
        ),
      ];
    }
    return modules
        .map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ModuleCard(module: m),
            ))
        .toList();
  }

  // ---------------- Tips card ----------------
  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.amber50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.amber200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(color: AppColors.amber200.withOpacity(0.7), shape: BoxShape.circle),
            child: const Icon(Icons.lightbulb_outline, color: AppColors.amber800, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'TIPS CODING PEMULA',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.amber900,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Sintaks Dasar',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.amber700),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: AppColors.amber900, height: 1.5),
                    children: [
                      TextSpan(text: 'Selalu periksa sepasang tag buka dan tutup seperti '),
                      TextSpan(
                        text: '<p>...</p>',
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' serta tanda kurung '),
                      TextSpan(
                        text: 'alert()',
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ' agar tidak terjadi error sintaks.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Bottom nav ----------------
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.menu_book, 'label': 'Modul'},
      {'icon': Icons.pest_control_outlined, 'label': 'Studi Kasus'},
      {'icon': Icons.terminal, 'label': 'Lab Fix'},
      {'icon': Icons.insights_outlined, 'label': 'Progres'},
    ];

    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final isActive = _bottomNavIndex == index;
          final item = items[index];
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _bottomNavIndex = index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 24,
                    color: isActive ? AppColors.sky600 : AppColors.slate600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: isActive ? AppColors.sky600 : AppColors.slate600,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ------------------------------------------------------------
// Module Card widget
// ------------------------------------------------------------
class _ModuleCard extends StatelessWidget {
  final LearningModule module;
  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: module.iconBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: module.iconBorder),
                ),
                child: Icon(module.icon, color: module.iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(module.code,
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.slate900)),
                    Text(module.idMateri,
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: AppColors.slate500)),
                  ],
                ),
              ),
              Wrap(
                spacing: 6,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.emerald50,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.emerald200.withOpacity(0.5)),
                    ),
                    child: Text(module.level,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.emerald700)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.schedule, size: 13, color: AppColors.slate600),
                        const SizedBox(width: 3),
                        Text(module.duration,
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.slate600)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(module.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: AppColors.slate900)),
          const SizedBox(height: 4),
          Text(module.description,
              style: const TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.5)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate900,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              children: [
                Icon(module.bugIcon, size: 15, color: module.bugIconColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    module.bugSnippet,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: module.bugTextColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.emerald950.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF065F46).withOpacity(0.8)),
                  ),
                  child: Text(module.caseCount,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF6EE7B7))),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _MetaBadge(text: module.quizCount),
                      _MetaBadge(text: module.labCount),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(999)),
                  child: const Icon(Icons.arrow_forward, size: 18, color: AppColors.slate700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final String text;
  const _MetaBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.slate700),
      ),
    );
  }
}