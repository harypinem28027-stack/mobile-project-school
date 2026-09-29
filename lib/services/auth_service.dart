import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan & membaca status login siswa secara lokal di device
/// (pakai shared_preferences), supaya tidak perlu login ulang setiap
/// kali app dibuka/ditutup.
///
/// Dipakai lewat:
/// ```dart
/// await AuthService.login(name: 'Alifia', studentId: 'SIS-2026-0891');
/// final sudahLogin = await AuthService.isLoggedIn();
/// await AuthService.logout();
/// ```
class AuthService {
  AuthService._();

  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyStudentName = 'student_name';
  static const _keyStudentId = 'student_id';

  /// Cek apakah siswa sedang dalam status login (dipanggil SplashPage
  /// saat app baru dibuka).
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Simpan status login. Dipanggil setelah LoginPage berhasil
  /// memvalidasi akun siswa.
  static Future<void> login({String? name, String? studentId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    if (name != null) await prefs.setString(_keyStudentName, name);
    if (studentId != null) await prefs.setString(_keyStudentId, studentId);
  }

  /// Hapus status login (dipanggil saat siswa menekan "Keluar Akun").
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  static Future<String?> getStudentName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyStudentName);
  }

  static Future<String?> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyStudentId);
  }
}
