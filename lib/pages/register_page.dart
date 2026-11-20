import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/eclipse_theme_toggle.dart';
import '../widgets/glass_morphism_box.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _idFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  late final AnimationController _dropController;

  bool obscurePassword = true;
  bool obscureConfirm = true;
  bool agreeTerms = false;
  bool isSubmitting = false;
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _dropController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 850),
    )..forward();

    _nameFocus.addListener(_onFocusChanged);
    _emailFocus.addListener(_onFocusChanged);
    _idFocus.addListener(_onFocusChanged);
    _passwordFocus.addListener(_onFocusChanged);
    _confirmFocus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _dropController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _idFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    nameController.dispose();
    emailController.dispose();
    idController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget _dropItem({
    required double start,
    required double end,
    required Widget child,
    double dropDistance = 34.0,
  }) {
    final curve = CurvedAnimation(
      parent: _dropController,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: curve,
        child: child,
        builder: (context, cachedChild) {
          return Transform.translate(
            offset: Offset(0, -(1.0 - curve.value) * dropDistance),
            child: cachedChild,
          );
        },
      ),
    );
  }

  int get passwordStrength {
    final password = passwordController.text;
    if (password.isEmpty) return 0;

    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;
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

  bool get passwordsMatch {
    return confirmController.text.isNotEmpty &&
        passwordController.text == confirmController.text;
  }

  Future<void> _submitRegistration() async {
    FocusScope.of(context).unfocus();

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
      _showMessage('Semua data wajib diisi.', isError: true);
      return;
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(email)) {
      _showMessage('Format email belum sesuai.', isError: true);
      return;
    }

    if (password.length < 8) {
      _showMessage('Kata sandi minimal 8 karakter.', isError: true);
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Konfirmasi kata sandi tidak sesuai.', isError: true);
      return;
    }

    if (!agreeTerms) {
      _showMessage(
        'Silakan setujui Syarat & Ketentuan serta Kebijakan Privasi.',
        isError: true,
      );
      return;
    }

    setState(() {
      isSubmitting = true;
      isRegistered = false;
    });

    await Future.delayed(Duration(milliseconds: 900));

    if (!mounted) return;
    HapticFeedback.mediumImpact();

    setState(() {
      isSubmitting = false;
      isRegistered = true;
    });
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError
            ? const Color(0xFFBE123C)
            : const Color(0xFF0F172A).withOpacity(0.92),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        margin: EdgeInsets.only(bottom: 24, left: 20, right: 20),
      ),
    );
  }

  Widget _buildGlassBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.sky50.withOpacity(0.88),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.sky700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
            },
            child: GlassMorphismBox(
              borderRadius: 999,
              opacity: 0.58,
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.slate800,
                size: 19,
              ),
            ),
          ),
          SizedBox(width: 10),
          GlassMorphismBox(
            borderRadius: 999,
            opacity: 0.55,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.terminal_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'DebugTIK',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.slate900,
                  ),
                ),
                SizedBox(width: 6),
                _buildGlassBadge('v2.4'),
              ],
            ),
          ),
          Spacer(),
          EclipseThemeToggle(
            isDark: ThemeController.instance.isDark,
            onToggle: ThemeController.instance.toggleTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildGlassBadge('siswa • id_siswa • learning_path'),
        SizedBox(height: 12),
        Text(
          'Registrasi Akun Siswa TIK',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
            letterSpacing: -0.4,
            height: 1.2,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Daftar untuk memulai praktikum kode interaktif, simulasi bug lab, dan pencatatan progres kompetensi TIK.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.8,
            height: 1.45,
            color: AppColors.slate600,
          ),
        ),
      ],
    );
  }

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
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate800,
                  ),
                ),
              ),
              if (badge != null) ...[
                SizedBox(width: 7),
                _buildGlassBadge(badge),
              ],
            ],
          ),
        ),
        if (meta != null) ...[
          SizedBox(width: 8),
          Text(
            meta,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: AppColors.slate500,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGlassTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required String hint,
    String? badge,
    String? meta,
    String? helper,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
  }) {
    final isFocused = focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: label, badge: badge, meta: meta),
        SizedBox(height: 8),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.glassFill.withOpacity(isFocused ? 0.88 : 0.64),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isFocused ? AppColors.sky600 : AppColors.glassBorder,
              width: isFocused ? 1.6 : 1.2,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: AppColors.sky600.withOpacity(0.14),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate900,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.slate500,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                icon,
                size: 20,
                color: isFocused ? AppColors.sky600 : AppColors.slate500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
        if (helper != null) ...[
          SizedBox(height: 6),
          Text(
            helper,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.slate600,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGlassPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool obscure,
    required VoidCallback onToggle,
    required IconData prefixIcon,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
  }) {
    final isFocused = focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.slate800,
          ),
        ),
        SizedBox(height: 8),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.glassFill.withOpacity(isFocused ? 0.88 : 0.64),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isFocused ? AppColors.sky600 : AppColors.glassBorder,
              width: isFocused ? 1.6 : 1.2,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: AppColors.sky600.withOpacity(0.14),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscure,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            onChanged: (_) => setState(() {}),
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate900,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.slate500,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                prefixIcon,
                size: 20,
                color: isFocused ? AppColors.sky600 : AppColors.slate500,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onToggle();
                },
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 20,
                  color: obscure ? AppColors.slate500 : AppColors.sky600,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStrength() {
    final strength = passwordStrength;
    if (passwordController.text.isEmpty) return SizedBox.shrink();

    final barColor = strength >= 3
        ? AppColors.emerald700
        : (strength == 2 ? AppColors.amber700 : const Color(0xFFE11D48));

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 220),
                  height: 5,
                  margin: EdgeInsets.only(right: index == 3 ? 0 : 5),
                  decoration: BoxDecoration(
                    color: index < strength
                        ? barColor
                        : AppColors.glassFill.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 5),
          Text(
            passwordStrengthText,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: barColor,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchStatus() {
    if (confirmController.text.isEmpty) return SizedBox.shrink();
    final match = passwordsMatch;

    return Padding(
      padding: EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Icon(
            match ? Icons.check_circle_rounded : Icons.error_rounded,
            size: 15,
            color: match ? AppColors.emerald700 : const Color(0xFFE11D48),
          ),
          SizedBox(width: 5),
          Text(
            match ? 'Kata sandi sesuai' : 'Kata sandi belum sesuai',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: match ? AppColors.emerald700 : const Color(0xFFE11D48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerms() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => agreeTerms = !agreeTerms);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 180),
              width: 20,
              height: 20,
              margin: EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: agreeTerms
                    ? LinearGradient(
                        colors: [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
                      )
                    : null,
                color: agreeTerms ? null : AppColors.glassFill.withOpacity(0.75),
                border: Border.all(
                  color: agreeTerms ? Colors.transparent : AppColors.slate300,
                ),
              ),
              child: agreeTerms
                  ? Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: AppColors.slate600,
                  ),
                  children: [
                    TextSpan(text: 'Saya menyetujui '),
                    TextSpan(
                      text: 'Syarat & Ketentuan',
                      style: TextStyle(
                        color: AppColors.sky600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: ' serta '),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: TextStyle(
                        color: AppColors.sky600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    if (isRegistered) {
      return Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF047857), const Color(0xFF10B981)],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.28),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
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

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.32),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : _submitRegistration,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSubmitting)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              )
            else
              Icon(Icons.person_add_rounded, size: 19),
            SizedBox(width: 8),
            Text(
              isSubmitting ? 'Memproses Data Lab...' : 'Daftar Akun Siswa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    if (!isRegistered) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.emerald50.withOpacity(0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.emerald700,
            size: 18,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Pendaftaran Siswa berhasil! Silakan masuk menggunakan akun yang telah didaftarkan.',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: AppColors.emerald700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginFooter() {
    final isDark = ThemeController.instance.isDark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      },
      child: GlassMorphismBox(
        borderRadius: 999,
        opacity: isDark ? 0.65 : 0.56,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sudah memiliki akun?',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: AppColors.slate600,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Masuk Akun Siswa',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 13,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDark;

    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Stack(
        children: [
          Positioned(
            top: -70,
            left: -50,
            child: _AmbientBlob(
              size: 260,
              color: AppColors.sky600.withOpacity(isDark ? 0.22 : 0.16),
            ),
          ),
          Positioned(
            top: 240,
            right: -70,
            child: _AmbientBlob(
              size: 250,
              color: const Color(0xFF6366F1).withOpacity(isDark ? 0.20 : 0.14),
            ),
          ),
          Positioned(
            bottom: -60,
            left: 20,
            child: _AmbientBlob(
              size: 240,
              color: const Color(0xFF38BDF8).withOpacity(isDark ? 0.18 : 0.14),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _dropItem(
                  start: 0.0,
                  end: 0.42,
                  dropDistance: 26,
                  child: _buildTopHeader(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(18, 10, 18, 28),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 460),
                        child: Column(
                          children: [
                            SizedBox(height: 6),
                            _dropItem(
                              start: 0.10,
                              end: 0.55,
                              dropDistance: 32,
                              child: _buildPageHeader(),
                            ),
                            SizedBox(height: 18),
                            _dropItem(
                              start: 0.22,
                              end: 0.80,
                              dropDistance: 40,
                              child: GlassMorphismBox(
                                borderRadius: 32,
                                opacity: isDark ? 0.65 : 0.56,
                                padding:
                                    EdgeInsets.fromLTRB(22, 24, 22, 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildGlassTextField(
                                      label: 'Nama Lengkap',
                                      controller: nameController,
                                      focusNode: _nameFocus,
                                      icon: Icons.person_outline_rounded,
                                      hint: 'Nama lengkap Anda',
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) =>
                                          _emailFocus.requestFocus(),
                                    ),
                                    SizedBox(height: 18),
                                    _buildGlassTextField(
                                      label: 'Email Siswa',
                                      badge: 'email',
                                      meta: 'DOMAIN AKADEMIK',
                                      controller: emailController,
                                      focusNode: _emailFocus,
                                      icon: Icons.mail_outline_rounded,
                                      hint: 'siswa@sekolah.sch.id',
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) =>
                                          _idFocus.requestFocus(),
                                    ),
                                    SizedBox(height: 18),
                                    _buildGlassTextField(
                                      label: 'NISN / ID Siswa',
                                      badge: 'id_siswa',
                                      meta: 'FORMAT TIK',
                                      controller: idController,
                                      focusNode: _idFocus,
                                      icon: Icons.badge_outlined,
                                      hint: 'Contoh: SIS-2026-0892',
                                      helper:
                                          'Masukkan NISN resmi atau Nomor Induk Lab yang diterbitkan pengajar TIK.',
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) =>
                                          _passwordFocus.requestFocus(),
                                    ),
                                    SizedBox(height: 18),
                                    _buildGlassPasswordField(
                                      label: 'Kata Sandi',
                                      hint: 'Minimal 8 karakter',
                                      controller: passwordController,
                                      focusNode: _passwordFocus,
                                      obscure: obscurePassword,
                                      prefixIcon: Icons.lock_outline_rounded,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) =>
                                          _confirmFocus.requestFocus(),
                                      onToggle: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
                                    ),
                                    _buildPasswordStrength(),
                                    SizedBox(height: 18),
                                    _buildGlassPasswordField(
                                      label: 'Konfirmasi Kata Sandi',
                                      hint: 'Ulangi kata sandi Anda',
                                      controller: confirmController,
                                      focusNode: _confirmFocus,
                                      obscure: obscureConfirm,
                                      prefixIcon: Icons.lock_reset_rounded,
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (_) => _submitRegistration(),
                                      onToggle: () {
                                        setState(() {
                                          obscureConfirm = !obscureConfirm;
                                        });
                                      },
                                    ),
                                    _buildMatchStatus(),
                                    SizedBox(height: 14),
                                    _buildTerms(),
                                    SizedBox(height: 18),
                                    _buildSubmitButton(),
                                    _buildFeedback(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            _dropItem(
                              start: 0.42,
                              end: 1.0,
                              dropDistance: 24,
                              child: _buildLoginFooter(),
                            ),
                          ],
                        ),
                      ),
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
}

class _AmbientBlob extends StatelessWidget {
  final double size;
  final Color color;

  _AmbientBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}