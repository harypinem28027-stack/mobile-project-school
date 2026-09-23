import 'package:flutter/material.dart';

class LabFixPage extends StatefulWidget {
  const LabFixPage({super.key});

  @override
  State<LabFixPage> createState() => _LabFixPageState();
}

class _LabFixPageState extends State<LabFixPage> {
  final TextEditingController codeController = TextEditingController();

  String selectedCondition = '';
  bool isSuccess = false;
  bool showHint = false;
  int selectedBottomIndex = 2;

  @override
  void initState() {
    super.initState();

    codeController.text = '<button>Klik Saya Disini';
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  // ============================================================
  // ACTION
  // ============================================================

  void setCondition(String value) {
    setState(() {
      selectedCondition = value;
      codeController.text = value;
    });
  }

  void quickFix() {
    setState(() {
      selectedCondition = '</button>';
      codeController.text = '</button>';
      isSuccess = false;
    });
  }

  void runTest() {
    final value = codeController.text.trim();

    final bool correct =
        value.contains('</button>') &&
        !value.contains('<button/>') &&
        !value.contains('</btn>');

    setState(() {
      isSuccess = correct;
    });
  }

  void resetCode() {
    setState(() {
      selectedCondition = '';
      codeController.text = '<button>Klik Saya Disini';
      isSuccess = false;
    });
  }

  void toggleHint() {
    setState(() {
      showHint = !showHint;
    });
  }

  void changeBottomNav(int index) {
    setState(() {
      selectedBottomIndex = index;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabHeader(),
                    const SizedBox(height: 16),

                    _buildQuickHint(),
                    const SizedBox(height: 16),

                    _buildCodeEditor(),
                    const SizedBox(height: 16),

                    _buildTerminal(),
                    const SizedBox(height: 16),

                    _buildActionButtons(),
                    const SizedBox(height: 16),

                    if (showHint) _buildTeacherHint(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ============================================================
  // TOP HEADER
  // ============================================================

  Widget _buildTopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF0EA5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.code,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(width: 10),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DebugTIK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'EduTIK',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0EA5E9),
                ),
              ),
            ],
          ),

          const Spacer(),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color(0xFF475569),
            ),
          ),

          Stack(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE0F2FE),
                  border: Border.all(
                    color: const Color(0xFFBAE6FD),
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF0284C7),
                  size: 21,
                ),
              ),

              Positioned(
                right: 0,
                bottom: 1,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LAB HEADER
  // ============================================================

  Widget _buildLabHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _badge(
                'HTML-001',
                const Color(0xFFE0F2FE),
                const Color(0xFF0369A1),
              ),

              const SizedBox(width: 8),

              _badge(
                'WEB-TAG-01',
                const Color(0xFFF1F5F9),
                const Color(0xFF475569),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            'Materi: HTML Dasar',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Dasar HTML & Struktur Web',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Praktik Sederhana: Memperbaiki '
            'Tag Penutup HTML yang Hilang',
            style: TextStyle(
              fontSize: 20,
              height: 1.25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Perbaiki heading dan button yang memiliki '
            'tag penutup yang belum lengkap.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  color: Color(0xFF0EA5E9),
                  size: 20,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'ID Progress: PRG-409',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Sedang Dikerjakan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '2x kesalahan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEA580C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BADGE
  // ============================================================

  Widget _badge(
    String text,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: foreground,
        ),
      ),
    );
  }

  // ============================================================
  // QUICK HINT
  // ============================================================

  Widget _buildQuickHint() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFDE68A),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFFD97706),
            size: 21,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF78350F),
                ),
                children: [
                  TextSpan(
                    text: 'Quick Hint\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Elemen HTML biasanya memiliki pasangan '
                        'tag pembuka dan penutup. Contohnya ',
                  ),
                  TextSpan(
                    text: '<tag>',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: ' dan '),
                  TextSpan(
                    text: '</tag>',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CODE EDITOR
  // ============================================================

  Widget _buildCodeEditor() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Editor Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.insert_drive_file_outlined,
                  color: Color(0xFF38BDF8),
                  size: 17,
                ),
                SizedBox(width: 8),
                Text(
                  'index.html',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          // Code
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              children: [
                _codeLine(
                  1,
                  '<h1>Belajar Web Pertama</h1>',
                ),
                _codeLine(
                  2,
                  '<p>Halo teman-teman! Ini halaman pertama saya.</p>',
                ),
                _codeLine(
                  3,
                  '<!-- Bug baris 4: Lupa tag penutup button -->',
                  comment: true,
                ),
                _codeLine(
                  4,
                  '<button>Klik Saya Disini ...',
                  active: true,
                  error: true,
                ),
                _codeLine(
                  5,
                  '',
                ),
              ],
            ),
          ),

          // Input section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFF111827),
              border: Border(
                top: BorderSide(
                  color: Color(0xFF334155),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Input Tag Penutup Baris 4',
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: codeController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Masukkan tag penutup...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 11,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1E293B),
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 11,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xFF334155),
                            ),
                          ),
                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xFF334155),
                            ),
                          ),
                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCondition = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 8),

                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: quickFix,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF0EA5E9),
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(9),
                          ),
                        ),
                        child: const Icon(
                          Icons.auto_fix_high,
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                const Text(
                  'Pilih kondisi:',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    _conditionButton('</button>'),
                    _conditionButton('<button/>'),
                    _conditionButton('</btn>'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeLine(
    int number,
    String code, {
    bool active = false,
    bool error = false,
    bool comment = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      color: active
          ? const Color(0xFF1E3A5F)
          : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              number.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: active
                    ? const Color(0xFF38BDF8)
                    : const Color(0xFF64748B),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              code,
              style: TextStyle(
                color: comment
                    ? const Color(0xFF64748B)
                    : error
                        ? const Color(0xFFFCA5A5)
                        : const Color(0xFFE2E8F0),
                fontSize: 11,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),

          if (error)
            const Icon(
              Icons.error_outline,
              color: Color(0xFFFB7185),
              size: 16,
            ),
        ],
      ),
    );
  }

  // ============================================================
  // CONDITION BUTTON
  // ============================================================

  Widget _conditionButton(String value) {
    final bool selected = selectedCondition == value;

    return InkWell(
      onTap: () => setCondition(value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF0EA5E9)
              : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? const Color(0xFF38BDF8)
                : const Color(0xFF334155),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: selected
                ? Colors.white
                : const Color(0xFFCBD5E1),
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TERMINAL
  // ============================================================

  Widget _buildTerminal() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF111827),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                _terminalDot(
                  const Color(0xFFEF4444),
                ),
                const SizedBox(width: 5),
                _terminalDot(
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 5),
                _terminalDot(
                  const Color(0xFF22C55E),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Console: Node.js v18.16',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isSuccess
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: isSuccess
                          ? const Color(0xFF22C55E)
                          : const Color(0xFFF59E0B),
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        isSuccess
                            ? 'STATUS: Perbaikan berhasil!'
                            : 'STATUS: Tag <button> belum ditutup!',
                        style: TextStyle(
                          color: isSuccess
                              ? const Color(0xFF86EFAC)
                              : const Color(0xFFFCD34D),
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                const Divider(
                  color: Color(0xFF1E293B),
                  height: 1,
                ),

                const SizedBox(height: 14),

                const Text(
                  'TRACE',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                if (isSuccess)
                  _successTrace()
                else
                  _failedTrace(),

                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: isSuccess
                        ? const Color(0xFF052E16)
                        : const Color(0xFF3F0D17),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: isSuccess
                          ? const Color(0xFF166534)
                          : const Color(0xFF881337),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isSuccess
                            ? Icons.check
                            : Icons.info_outline,
                        color: isSuccess
                            ? const Color(0xFF4ADE80)
                            : const Color(0xFFFB7185),
                        size: 17,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          isSuccess
                              ? 'Diagnosis: Tag penutup sudah sesuai. '
                                  'Kode dapat dijalankan dengan baik.'
                              : 'Diagnosis: Tambahkan </button> '
                                  'di akhir elemen button.',
                          style: TextStyle(
                            color: isSuccess
                                ? const Color(0xFFBBF7D0)
                                : const Color(0xFFFDA4AF),
                            fontSize: 11,
                            height: 1.5,
                            fontFamily: 'monospace',
                          ),
                        ),
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

  Widget _terminalDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _failedTrace() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '> checking index.html...',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> error: tag penutup hilang',
          style: TextStyle(
            color: Color(0xFFFB7185),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> expected: <button>Klik Saya Disini</button>',
          style: TextStyle(
            color: Color(0xFFFCD34D),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> current: <button>Klik Saya Disini',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _successTrace() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '> checking index.html...',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> tag penutup ditemukan',
          style: TextStyle(
            color: Color(0xFF4ADE80),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> expected: <button>Klik Saya Disini</button>',
          style: TextStyle(
            color: Color(0xFF86EFAC),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> result: 3/3 test passed',
          style: TextStyle(
            color: Color(0xFF4ADE80),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 5),
        Text(
          '> execution: clean',
          style: TextStyle(
            color: Color(0xFF4ADE80),
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: runTest,
            icon: const Icon(
              Icons.play_arrow_rounded,
              size: 21,
            ),
            label: const Text(
              'Uji Perbaikan Kode (Run Test)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5E9),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),

        const SizedBox(height: 9),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: toggleHint,
                icon: const Icon(
                  Icons.school_outlined,
                  size: 18,
                ),
                label: const Text(
                  'Minta Petunjuk Guru',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      const Color(0xFF0369A1),
                  side: const BorderSide(
                    color: Color(0xFFBAE6FD),
                  ),
                  backgroundColor:
                      const Color(0xFFF0F9FF),
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: OutlinedButton.icon(
                onPressed: resetCode,
                icon: const Icon(
                  Icons.restart_alt,
                  size: 18,
                ),
                label: const Text(
                  'Reset Kode Awal',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      const Color(0xFF475569),
                  side: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // TEACHER HINT
  // ============================================================

  Widget _buildTeacherHint() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFBAE6FD),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  'Petunjuk dari Pak Guru (AI Tutor)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),

              IconButton(
                onPressed: toggleHint,
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            'Tag <button> digunakan untuk membuat '
            'tombol pada halaman HTML. Setiap tag pembuka '
            'perlu memiliki tag penutup.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF475569),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '<button>Klik Saya Disini</button>',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Color(0xFF0369A1),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Jadi, yang perlu kamu tambahkan di akhir '
            'baris adalah </button>.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    final items = [
      (
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book,
        label: 'Modul',
      ),
      (
        icon: Icons.bug_report_outlined,
        activeIcon: Icons.bug_report,
        label: 'Studi Kasus',
      ),
      (
        icon: Icons.build_outlined,
        activeIcon: Icons.build,
        label: 'Lab Fix',
      ),
      (
        icon: Icons.bar_chart_outlined,
        activeIcon: Icons.bar_chart,
        label: 'Progres',
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 7,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];
                final bool active =
                    selectedBottomIndex == index;

                return Expanded(
                  child: InkWell(
                    onTap: () =>
                        changeBottomNav(index),
                    borderRadius:
                        BorderRadius.circular(12),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            active
                                ? item.activeIcon
                                : item.icon,
                            size: 21,
                            color: active
                                ? const Color(0xFF0EA5E9)
                                : const Color(0xFF64748B),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: active
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: active
                                  ? const Color(0xFF0EA5E9)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}