
import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberMe = true;
  bool isLoading = false;

  Future<void> triggerLogin() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'NISN/Email dan kata sandi wajib diisi.',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil masuk!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void triggerSSO() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Akun Belajar.id'),
          content: const Text(
            'Mengarahkan ke Single Sign-On Portal '
            '(Akun Belajar.id)...',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF006194);
    const surfaceColor = Color(0xFFF8F9FF);
    const surfaceLow = Color(0xFFEFF4FF);
    const outlineColor = Color(0xFFBFC7D2);
    const textColor = Color(0xFF0B1C30);
    const secondaryText = Color(0xFF3F4850);

    return Scaffold(
      backgroundColor: surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: surfaceColor.withOpacity(0.95),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.code,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'DebugTIK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'V2.4',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: secondaryText,
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryText,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            // ================= BODY =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // ================= GREETING =================
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5EEFF),
                            borderRadius:
                                BorderRadius.circular(30),
                            border: Border.all(
                              color: outlineColor.withOpacity(0.3),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.school,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'PORTAL BELAJAR SISWA TIK',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Masuk Akun Siswa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Akses modul interaktif, praktikum debugging, '
                            'dan catatan live query pembelajaran Anda.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: secondaryText,
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ================= CARD =================
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),
                            border: Border.all(
                              color: outlineColor.withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // ================= ROLE =================
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: surfaceLow,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        outlineColor.withOpacity(0.4),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(9),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Peserta Didik',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                  color: textColor,
                                                ),
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                'PK: id_siswa',
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Akses Terverifikasi Dapodik & Lab TIK',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const Icon(
                                      Icons.verified,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // ================= EMAIL =================
                              _buildLabel(
                                'NISN / ID Siswa / Email Siswa',
                                '[VARCHAR 128]',
                              ),

                              const SizedBox(height: 7),

                              TextField(
                                controller: emailController,
                                keyboardType:
                                    TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText:
                                      'NISN (10 digit) atau email siswa',
                                  prefixIcon: const Icon(
                                    Icons.badge_outlined,
                                    size: 20,
                                  ),
                                  filled: true,
                                  fillColor: surfaceColor,
                                  border: _inputBorder(),
                                  enabledBorder: _inputBorder(),
                                  focusedBorder:
                                      _focusedBorder(primaryColor),
                                ),
                              ),

                              const SizedBox(height: 6),

                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Masukkan NISN aktif atau email yang terdaftar '
                                  'pada sistem lab TIK sekolah.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryText,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // ================= PASSWORD =================
                              Row(
                                children: [
                                  const Text(
                                    'Kata Sandi',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Fitur lupa kata sandi belum tersedia.',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Lupa kata sandi?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 7),

                              TextField(
                                controller: passwordController,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan kata sandi',
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible =
                                            !isPasswordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: surfaceColor,
                                  border: _inputBorder(),
                                  enabledBorder: _inputBorder(),
                                  focusedBorder:
                                      _focusedBorder(primaryColor),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // ================= REMEMBER =================
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    activeColor: primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe =
                                            value ?? false;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Ingat saya',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryText,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // ================= INFO =================
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: surfaceLow.withOpacity(0.8),
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        outlineColor.withOpacity(0.4),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.schema_outlined,
                                      color: primaryColor,
                                      size: 18,
                                    ),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'AUTO-BINDING ERD',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              const SizedBox(width: 7),
                                              Container(
                                                padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                  horizontal: 5,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(
                                                    0xFFE5EEFF,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(4),
                                                ),
                                                child: const Text(
                                                  'FK: progress_belajar',
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color:
                                                        secondaryText,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 4),

                                          const Text(
                                            'Sesi login otomatis memuat riwayat '
                                            'learning_path dan sinkronisasi log '
                                            'error praktikum siswa terkini.',
                                            style: TextStyle(
                                              fontSize: 11,
                                              height: 1.4,
                                              color: secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 14),

                              // ================= LOGIN BUTTON =================
                              SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed:
                                      isLoading ? null : triggerLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 18,
                                              height: 18,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Mengautentikasi...',
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Masuk ke Modul Siswa',
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // ================= DIVIDER =================
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: Color(0xFFDCE9FF),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'atau masuk dengan',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: secondaryText,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: Color(0xFFDCE9FF),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // ================= GOOGLE =================
                              SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: OutlinedButton(
                                  onPressed: triggerSSO,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: textColor,
                                    side: BorderSide(
                                      color:
                                          outlineColor.withOpacity(0.6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'G',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                                  FontWeight.bold,
                                              color:
                                                  Color(0xFF4285F4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Akun Belajar.id / Google',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= REGISTER =================
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum terdaftar sebagai Siswa?',
                              style: TextStyle(
                                fontSize: 13,
                                color: secondaryText,
                              ),
                            ),

                            const SizedBox(width: 5),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Aktivasi Akun Siswa',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.open_in_new,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

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

  // ================= HELPER =================

  Widget _buildLabel(String title, String type) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0B1C30),
            ),
          ),
        ),
        Text(
          type,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF006194),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: const Color(0xFFBFC7D2).withOpacity(0.5),
      ),
    );
  }

  OutlineInputBorder _focusedBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color,
        width: 1.5,
      ),
    );
  }
}
