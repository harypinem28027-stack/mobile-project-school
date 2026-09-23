import 'dart:async';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ============================================================
  // COLOR
  // ============================================================

  static const Color surface = Color(0xFFF8F9FF);
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color onSurfaceVariant = Color(0xFF3F4850);

  static const Color primary = Color(0xFF006194);
  static const Color primaryContainer = Color(0xFF007BB9);

  static const Color secondary = Color(0xFF006591);
  static const Color secondaryFixed = Color(0xFFC9E6FF);

  static const Color tertiary = Color(0xFF006947);
  static const Color tertiaryFixed = Color(0xFF6FFBBE);

  static const Color error = Color(0xFFBA1A1A);

  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color outline = Color(0xFF707881);

  // ============================================================
  // CONTROLLER
  // ============================================================

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  String selectedPath = 'frontend';

  bool obscurePassword = true;
  bool obscureConfirm = true;

  bool agreeTerms = false;

  bool isSubmitting = false;
  bool isRegistered = false;

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    idController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  // ============================================================
  // PASSWORD STRENGTH
  // ============================================================

  int get passwordStrength {
    final password = passwordController.text;

    if (password.isEmpty) {
      return 0;
    }

    int strength = 0;

    if (password.length >= 8) {
      strength++;
    }

    if (RegExp(r'[A-Z]').hasMatch(password)) {
      strength++;
    }

    if (RegExp(r'[0-9]').hasMatch(password)) {
      strength++;
    }

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      strength++;
    }

    return strength;
  }

  String get passwordStrengthText {
    switch (passwordStrength) {
      case 0:
        return 'Minimal 8 karakter';
      case 1:
        return 'LEMAH';
      case 2:
        return 'CUKUP';
      case 3:
        return 'BAIK';
      case 4:
        return 'KUAT';
      default:
        return '';
    }
  }

  // ============================================================
  // PASSWORD MATCH
  // ============================================================

  bool get passwordsMatch {
    return confirmController.text.isNotEmpty &&
        passwordController.text == confirmController.text;
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  Future<void> _submitRegistration() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final studentId = idController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        studentId.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Semua data wajib diisi.');
      return;
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(email)) {
      _showMessage('Format email belum sesuai.');
      return;
    }

    if (password.length < 8) {
      _showMessage('Kata sandi minimal 8 karakter.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Konfirmasi kata sandi tidak sesuai.');
      return;
    }

    if (!agreeTerms) {
      _showMessage(
        'Silakan setujui Syarat & Ketentuan serta Kebijakan Privasi.',
      );
      return;
    }

    setState(() {
      isSubmitting = true;
      isRegistered = false;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      isSubmitting = false;
      isRegistered = true;
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BADGE
  // ============================================================

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: primary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ============================================================
  // TOP HEADER
  // ============================================================

  Widget _buildTopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // BACK BUTTON
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: onSurface,
                size: 21,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // LOGO
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: surfaceContainer,
              borderRadius: BorderRadius.circular(9),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida/AEtjO1VTMYF2xwEWsBbXaxD28g5jaoFyCCtcZHGxILOvlAcyaBbYJ2G3-Tr9_9Izjm0SJiatPowRTpU00JliL0D_CgeXL7GI_PYK2CgnHQXPSvqWQqhmudP90dU_aw-rUJh1ulz3BhRXOhXBTDrH3AvZmdteBg1PeIMfTdt4Z_Fd-Ul7Mc8BQUEGLhvsJaoVcqfrDyDhtLS-3HFQOhtyP8eRJ706IJuJiCIc8IOHY-tCohIBYt5ixy-tf_jLhfo',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.code,
                  color: primary,
                );
              },
            ),
          ),

          const SizedBox(width: 9),

          // DEBUGTIK
          const Text(
            'DebugTIK',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: onSurface,
            ),
          ),

          const SizedBox(width: 6),

          _buildBadge('v2.4'),

          const Spacer(),

          // CREATE ACCOUNT
          const Text(
            'Create Account',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: onSurfaceVariant,
            ),
          ),

          const SizedBox(width: 9),

          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildBadge(
              'siswa (id_siswa, learning_path, current_level)',
            ),
          ],
        ),

        const SizedBox(height: 15),

        const Text(
          'Registrasi Akun Siswa TIK',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: onSurface,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Daftar untuk memulai praktikum kode interaktif, '
          'simulasi bug lab, dan pencatatan progres kompetensi TIK.',
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle({
    required String title,
    String? badge,
    String? meta,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: onSurface,
                  ),
                ),
              ),

              if (badge != null) ...[
                const SizedBox(width: 7),
                _buildBadge(badge),
              ],
            ],
          ),
        ),

        if (meta != null) ...[
          const SizedBox(width: 8),
          Text(
            meta,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: outline,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    String? badge,
    String? meta,
    String? helper,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          title: label,
          badge: badge,
          meta: meta,
        ),

        const SizedBox(height: 9),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 14,
            color: onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: outline,
              fontSize: 13,
            ),
            prefixIcon: Icon(
              icon,
              size: 20,
              color: primary,
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: outline.withOpacity(0.18),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: primary,
                width: 1.5,
              ),
            ),
          ),
        ),

        if (helper != null) ...[
          const SizedBox(height: 7),
          Text(
            helper,
            style: const TextStyle(
              fontSize: 11,
              color: onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // LEARNING PATH
  // ============================================================

  Widget _buildPathOption({
    required String value,
    required String title,
    required String description,
    required IconData icon,
  }) {
    final bool selected = selectedPath == value;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          selectedPath = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected
              ? secondaryFixed
              : surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? primary
                : outline.withOpacity(0.18),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withOpacity(0.75)
                    : surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: primary,
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Icon(
              selected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: selected ? primary : outline,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PASSWORD FIELD
  // ============================================================

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    required IconData prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: onSurface,
          ),
        ),

        const SizedBox(height: 9),

        TextField(
          controller: controller,
          obscureText: obscure,
          onChanged: (_) {
            setState(() {});
          },
          style: const TextStyle(
            fontSize: 14,
            color: onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: outline,
              fontSize: 13,
            ),
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: primary,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 20,
                color: outline,
              ),
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(
                color: outline.withOpacity(0.18),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PASSWORD STRENGTH
  // ============================================================

  Widget _buildPasswordStrength() {
    final strength = passwordStrength;

    if (passwordController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              4,
              (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(
                      right: index == 3 ? 0 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: index < strength
                          ? primary
                          : surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 5),

          Text(
            passwordStrengthText,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: strength >= 3
                  ? tertiary
                  : error,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONFIRM PASSWORD STATUS
  // ============================================================

  Widget _buildMatchStatus() {
    if (confirmController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final match = passwordsMatch;

    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Icon(
            match ? Icons.check_circle : Icons.error,
            size: 14,
            color: match ? tertiary : error,
          ),
          const SizedBox(width: 5),
          Text(
            match
                ? 'Kata sandi sesuai'
                : 'Kata sandi belum sesuai',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: match ? tertiary : error,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TERMS
  // ============================================================

  Widget _buildTerms() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          agreeTerms = !agreeTerms;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: agreeTerms,
              onChanged: (value) {
                setState(() {
                  agreeTerms = value ?? false;
                });
              },
              activeColor: primary,
              visualDensity: VisualDensity.compact,
            ),

            const SizedBox(width: 4),

            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 7),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.5,
                      color: onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        text: 'Saya menyetujui ',
                      ),
                      TextSpan(
                        text: 'Syarat & Ketentuan',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' serta ',
                      ),
                      TextSpan(
                        text: 'Kebijakan Privasi',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUBMIT BUTTON
  // ============================================================

  Widget _buildSubmitButton() {
    if (isRegistered) {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: tertiary,
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Terdaftar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isSubmitting
            ? null
            : _submitRegistration,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          disabledBackgroundColor: primaryContainer,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSubmitting)
              const SizedBox(
                width: 19,
                height: 19,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              )
            else
              const Icon(
                Icons.person_add,
                size: 19,
              ),

            const SizedBox(width: 8),

            Text(
              isSubmitting
                  ? 'Memproses Data Lab...'
                  : 'Daftar Akun Siswa',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUCCESS FEEDBACK
  // ============================================================

  Widget _buildFeedback() {
    if (!isRegistered) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tertiaryFixed.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: tertiary.withOpacity(0.25),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: tertiary,
            size: 18,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Pendaftaran Siswa berhasil! '
              'Mengalihkan ke lab praktikum...',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: tertiary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGIN FOOTER
  // ============================================================

  Widget _buildLoginFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah memiliki akun?',
          style: TextStyle(
            fontSize: 12,
            color: onSurfaceVariant,
          ),
        ),

        const SizedBox(width: 5),

        TextButton(
          onPressed: () {
            // Nanti bisa diarahkan ke LoginPage
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Row(
            children: [
              Text(
                'Masuk Akun Siswa',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: primary,
                ),
              ),
              SizedBox(width: 3),
              Icon(
                Icons.arrow_forward,
                size: 15,
                color: primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,

      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 650,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ========================================
                        // HEADER
                        // ========================================

                        _buildPageHeader(),

                        const SizedBox(height: 28),

                        // ========================================
                        // NAMA LENGKAP
                        // ========================================

                        _buildTextField(
                          label: 'Nama Lengkap',
                          controller: nameController,
                          icon: Icons.person_outline,
                          hint: 'Nama lengkap Anda',
                        ),

                        const SizedBox(height: 22),

                        // ========================================
                        // EMAIL
                        // ========================================

                        _buildTextField(
                          label: 'Email Siswa',
                          badge: 'email',
                          meta: 'DOMAIN AKADEMIK',
                          controller: emailController,
                          icon: Icons.mail_outline,
                          hint: 'siswa@sekolah.sch.id',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 22),

                        // ========================================
                        // NISN / ID SISWA
                        // ========================================

                        _buildTextField(
                          label: 'NISN / ID Siswa',
                          badge: 'id_siswa',
                          meta: 'FORMAT TIK',
                          controller: idController,
                          icon: Icons.badge_outlined,
                          hint: 'Contoh: SIS-2026-0892',
                          helper:
                              'Masukkan NISN resmi atau Nomor Induk Lab '
                              'yang diterbitkan pengajar TIK.',
                        ),

                        const SizedBox(height: 22),

                        // ========================================
                        // FOKUS JALUR PRAKTIKUM
                        // ========================================

                        _buildSectionTitle(
                          title: 'Fokus Jalur Praktikum',
                          badge: 'learning_path',
                          meta: 'LAB TIK',
                        ),

                        const SizedBox(height: 7),

                        const Text(
                          'Pilih kurikulum debugging awal yang akan '
                          'ditugaskan di repositori praktikum:',
                          style: TextStyle(
                            fontSize: 11,
                            color: onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 11),

                        _buildPathOption(
                          value: 'frontend',
                          title: 'Frontend & Web Layout',
                          description:
                              'HTML5, CSS Grid/Flexbox, DOM & '
                              'Layout shift debugging',
                          icon: Icons.web_outlined,
                        ),

                        _buildPathOption(
                          value: 'algoritma',
                          title: 'Algoritma & Logika',
                          description:
                              'Tracing breakpoint, off-by-one errors '
                              '& loop logic',
                          icon: Icons.account_tree_outlined,
                        ),

                        _buildPathOption(
                          value: 'async',
                          title: 'Asynchronous JS & API Integration',
                          description:
                              'Promise rejections, fetch state errors, '
                              'dan async bug audit',
                          icon: Icons.sync_alt,
                        ),

                        const SizedBox(height: 13),

                        // ========================================
                        // PASSWORD
                        // ========================================

                        _buildPasswordField(
                          label: 'Kata Sandi',
                          hint: 'Minimal 8 karakter',
                          controller: passwordController,
                          obscure: obscurePassword,
                          prefixIcon: Icons.lock_outline,
                          onToggle: () {
                            setState(() {
                              obscurePassword =
                                  !obscurePassword;
                            });
                          },
                        ),

                        _buildPasswordStrength(),

                        const SizedBox(height: 22),

                        // ========================================
                        // CONFIRM PASSWORD
                        // ========================================

                        _buildPasswordField(
                          label: 'Konfirmasi Kata Sandi',
                          hint: 'Ulangi kata sandi Anda',
                          controller: confirmController,
                          obscure: obscureConfirm,
                          prefixIcon: Icons.lock_reset_outlined,
                          onToggle: () {
                            setState(() {
                              obscureConfirm =
                                  !obscureConfirm;
                            });
                          },
                        ),

                        _buildMatchStatus(),

                        const SizedBox(height: 16),

                        // ========================================
                        // TERMS
                        // ========================================

                        _buildTerms(),

                        const SizedBox(height: 17),

                        // ========================================
                        // SUBMIT
                        // ========================================

                        _buildSubmitButton(),

                        _buildFeedback(),

                        const SizedBox(height: 18),

                        // ========================================
                        // LOGIN
                        // ========================================

                        _buildLoginFooter(),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}