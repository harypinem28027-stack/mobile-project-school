import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/eclipse_theme_toggle.dart';
import '../widgets/glass_morphism_box.dart';
import '../widgets/login_mascot_squad.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  late final AnimationController _dropController;

  bool isPasswordVisible = false;
  bool rememberMe = true;
  bool isLoading = false;
  int _nodCount = 0;

  @override
  void initState() {
    super.initState();
    _dropController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )..forward();

    _emailFocus.addListener(_onFocusChanged);
    _passwordFocus.addListener(_onFocusChanged);
    emailController.addListener(_onTextTyped);
    passwordController.addListener(_onTextTyped);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  void _onTextTyped() {
    if (mounted) {
      setState(() {
        _nodCount++;
      });
    }
  }

  int get _mascotMood {
    if (isPasswordVisible) return 2;
    if (_passwordFocus.hasFocus) return 1;
    return 0;
  }

  double get _lookRatio {
    if (_passwordFocus.hasFocus) {
      final len = passwordController.text.length;
      return ((len / 18.0) * 2.0 - 1.0).clamp(-1.0, 1.0);
    }
    if (_emailFocus.hasFocus) {
      final len = emailController.text.length;
      return ((len / 24.0) * 2.0 - 1.0).clamp(-1.0, 1.0);
    }
    return 0.0;
  }

  Widget _dropItem({
    required double start,
    required double end,
    required Widget child,
    double dropDistance = 38.0,
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

  Future<void> triggerLogin() async {
    FocusScope.of(context).unfocus();

    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showGlassSnack('NISN/Email dan kata sandi wajib diisi.', isError: true);
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(Duration(milliseconds: 550));

    if (!mounted) return;
    setState(() => isLoading = false);

    await AuthService.login(
      name: emailController.text.trim(),
      studentId: emailController.text.trim(),
    );

    if (!mounted) return;

    HapticFeedback.mediumImpact();

    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 360),
        pageBuilder: (_, __, ___) => HomePage(),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  void _showGlassSnack(String message, {bool isError = false}) {
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

  void triggerSSO() {
    HapticFeedback.lightImpact();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Tutup SSO',
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: Duration(milliseconds: 250),
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
                  opacity: 0.78,
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
                          color: AppColors.sky50,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.sky200),
                        ),
                        child: Center(
                          child: Text(
                            'G',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF4285F4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'SSO Akun Belajar.id',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.slate900,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Mengarahkan ke portal autentikasi Akun Belajar.id / Google sekolah...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.slate600,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.sky600,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Text(
                            'Mengerti',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
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
  }

  @override
  void dispose() {
    _dropController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mood = _mascotMood;
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
            top: 220,
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
                  end: 0.45,
                  dropDistance: 28,
                  child: _buildGlassHeader(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(18, 8, 18, 28),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 440),
                        child: Column(
                          children: [
                            SizedBox(height: 6),
                            _dropItem(
                              start: 0.12,
                              end: 0.58,
                              dropDistance: 34,
                              child: Column(
                                children: [
                                  Text(
                                    'Masuk Akun Siswa',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.slate900,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Lanjutkan belajar, kuis interaktif, dan latihan kode dalam satu tempat.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.45,
                                      color: AppColors.slate600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),

                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                _dropItem(
                                  start: 0.30,
                                  end: 0.82,
                                  dropDistance: 44,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 100),
                                    child: GlassMorphismBox(
                                      borderRadius: 32,
                                      opacity: isDark ? 0.65 : 0.56,
                                      padding: EdgeInsets.fromLTRB(
                                          22, 34, 22, 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'NISN atau Email Siswa',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.slate800,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          _buildGlassField(
                                            controller: emailController,
                                            focusNode: _emailFocus,
                                            hint:
                                                'Contoh: 0081234567 atau nama@siswa.id',
                                            icon: Icons.person_outline_rounded,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            onSubmitted: (_) =>
                                                _passwordFocus.requestFocus(),
                                          ),

                                          SizedBox(height: 18),

                                          Row(
                                            children: [
                                              Text(
                                                'Kata Sandi',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.slate800,
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () => _showGlassSnack(
                                                  'Hubungi admin lab TIK sekolah untuk reset sandi.',
                                                ),
                                                child: Text(
                                                  'Lupa kata sandi?',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.sky600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          _buildGlassField(
                                            controller: passwordController,
                                            focusNode: _passwordFocus,
                                            hint: 'Masukkan kata sandi',
                                            icon: Icons.lock_outline_rounded,
                                            obscureText: !isPasswordVisible,
                                            textInputAction:
                                                TextInputAction.done,
                                            onSubmitted: (_) => triggerLogin(),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                HapticFeedback.selectionClick();
                                                setState(() {
                                                  isPasswordVisible =
                                                      !isPasswordVisible;
                                                });
                                              },
                                              icon: Icon(
                                                isPasswordVisible
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                                size: 20,
                                                color: isPasswordVisible
                                                    ? AppColors.sky600
                                                    : AppColors.slate500,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 12),

                                          GestureDetector(
                                            onTap: () {
                                              HapticFeedback.selectionClick();
                                              setState(() =>
                                                  rememberMe = !rememberMe);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 180),
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    gradient: rememberMe
                                                        ? LinearGradient(
                                                            colors: [
                                                              AppColors.sky600,
                                                              Color(
                                                                  0xFF6366F1),
                                                            ],
                                                          )
                                                        : null,
                                                    color: rememberMe
                                                        ? null
                                                        : AppColors.glassFill
                                                            .withOpacity(0.75),
                                                    border: Border.all(
                                                      color: rememberMe
                                                          ? Colors.transparent
                                                          : AppColors.slate300,
                                                    ),
                                                  ),
                                                  child: rememberMe
                                                      ? Icon(
                                                          Icons.check_rounded,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Ingat sesi saya',
                                                  style: TextStyle(
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.slate600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                          Container(
                                            width: double.infinity,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  const Color(0xFF4F46E5),
                                                  const Color(0xFF6366F1),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF4F46E5)
                                                      .withOpacity(0.32),
                                                  blurRadius: 14,
                                                  offset: Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                              onPressed: isLoading
                                                  ? null
                                                  : triggerLogin,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          999),
                                                ),
                                              ),
                                              child: isLoading
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 18,
                                                          height: 18,
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2.2,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Memverifikasi...',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.5,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Masuk ke Modul Siswa',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          size: 18,
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),

                                          SizedBox(height: 18),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: AppColors.slate300
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Text(
                                                  'atau',
                                                  style: TextStyle(
                                                    fontSize: 11.5,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.slate500,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: AppColors.slate300
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 16),

                                          SizedBox(
                                            width: double.infinity,
                                            height: 46,
                                            child: OutlinedButton(
                                              onPressed: triggerSSO,
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.glassFill
                                                        .withOpacity(0.65),
                                                foregroundColor:
                                                    AppColors.slate800,
                                                side: BorderSide(
                                                  color: AppColors.glassBorder,
                                                  width: 1.2,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          999),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration:
                                                        BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'G',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              const Color(0xFF4285F4),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Masuk dengan Belajar.id',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 0,
                                  child: _dropItem(
                                    start: 0.22,
                                    end: 0.72,
                                    dropDistance: 52,
                                    child: LoginMascotSquad(
                                      mood: mood,
                                      lookRatio: _lookRatio,
                                      nodTrigger: _nodCount,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            // Pil Liquid Glass "Belum punya akun siswa? Aktivasi Sekarang"
                            _dropItem(
                              start: 0.45,
                              end: 1.0,
                              dropDistance: 24,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: GlassMorphismBox(
                                  borderRadius: 999,
                                  opacity: isDark ? 0.65 : 0.56,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Belum punya akun siswa?',
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.slate600,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 11,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFF4F46E5),
                                              const Color(0xFF6366F1),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF4F46E5)
                                                  .withOpacity(0.28),
                                              blurRadius: 8,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Aktivasi Sekarang',
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
          ),
        ],
      ),
    );
  }

  Widget _buildGlassHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
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
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.sky50,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'EduTIK',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.sky700,
                    ),
                  ),
                ),
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

  Widget _buildGlassField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
    Widget? suffixIcon,
  }) {
    final isFocused = focusNode.hasFocus;

    return AnimatedContainer(
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
        obscureText: obscureText,
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
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.slate500,
          ),
          prefixIcon: Icon(
            icon,
            size: 20,
            color: isFocused ? AppColors.sky600 : AppColors.slate500,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
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