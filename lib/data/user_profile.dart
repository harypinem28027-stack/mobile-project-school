import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Satu opsi avatar: ikon + warna gradasi.
class AvatarOption {
  final IconData icon;
  final List<Color> gradient;
  AvatarOption(this.icon, this.gradient);
}

/// 10 avatar bertema coding/IT untuk DebugTIK.
List<AvatarOption> kAvatarOptions = [
  AvatarOption(Icons.terminal, [const Color(0xFF0EA5E9), const Color(0xFF0369A1)]),
  AvatarOption(Icons.bug_report, [const Color(0xFFF43F5E), const Color(0xFFBE123C)]),
  AvatarOption(Icons.code, [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)]),
  AvatarOption(Icons.memory, [const Color(0xFF10B981), const Color(0xFF047857)]),
  AvatarOption(Icons.data_object, [const Color(0xFFF59E0B), const Color(0xFFB45309)]),
  AvatarOption(Icons.smart_toy, [const Color(0xFF6366F1), const Color(0xFF4338CA)]),
  AvatarOption(Icons.rocket_launch, [const Color(0xFFEC4899), const Color(0xFFBE185D)]),
  AvatarOption(Icons.auto_awesome, [const Color(0xFF14B8A6), const Color(0xFF0F766E)]),
  AvatarOption(Icons.developer_mode, [const Color(0xFF64748B), const Color(0xFF334155)]),
  AvatarOption(Icons.integration_instructions, [const Color(0xFF22C55E), const Color(0xFF15803D)]),
];

/// Pilihan fokus belajar siswa SMA/SMK di DebugTIK.
const List<String> kLearningFocusOptions = [
  'HTML Dasar',
  'CSS Layouting',
  'Logika JavaScript',
  'Dasar Web Lengkap',
];

/// Data profil global & reaktif (ChangeNotifier) + tersimpan permanen.
class UserProfile extends ChangeNotifier {
  UserProfile._internal();
  static final UserProfile instance = UserProfile._internal();

  static const _kName = 'profile_name';
  static const _kEmail = 'profile_email';
  static const _kClass = 'profile_student_class';
  static const _kStudentId = 'profile_student_id';
  static const _kFocus = 'profile_learning_focus';
  static const _kAvatar = 'profile_avatar_index';
  static const _kPassword = 'profile_password';

  String _name = 'Alifia Putri';
  String _email = 'alifia.putri@sekolah.sch.id';
  String _studentClass = 'XI TIK 2';
  String _studentId = 'SIS-2026-0891';
  String _learningFocus = 'Dasar Web Lengkap';
  int _avatarIndex = 0;
  String _password = 'password123'; // DEMO ONLY

  String get name => _name;
  String get email => _email;
  String get studentClass => _studentClass;
  String get studentId => _studentId;
  String get learningFocus => _learningFocus;
  int get avatarIndex => _avatarIndex;
  AvatarOption get avatar => kAvatarOptions[_avatarIndex];

  /// Dipanggil sekali saat aplikasi start (di main.dart).
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_kName) ?? _name;
    _email = prefs.getString(_kEmail) ?? _email;
    _studentClass = prefs.getString(_kClass) ?? _studentClass;
    _studentId = prefs.getString(_kStudentId) ?? _studentId;
    _learningFocus = prefs.getString(_kFocus) ?? _learningFocus;
    _password = prefs.getString(_kPassword) ?? _password;

    final i = prefs.getInt(_kAvatar);
    if (i != null && i >= 0 && i < kAvatarOptions.length) {
      _avatarIndex = i;
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_kName, _name),
      prefs.setString(_kEmail, _email),
      prefs.setString(_kClass, _studentClass),
      prefs.setString(_kStudentId, _studentId),
      prefs.setString(_kFocus, _learningFocus),
      prefs.setInt(_kAvatar, _avatarIndex),
      prefs.setString(_kPassword, _password),
    ]);
  }

  Future<void> updateName(String newName) async {
    if (newName.trim().isEmpty) return;
    _name = newName.trim();
    notifyListeners();
    await _save();
  }

  Future<void> updateProfile({
    required String newName,
    required String newClass,
    required String newFocus,
  }) async {
    if (newName.trim().isNotEmpty) {
      _name = newName.trim();
    }
    if (newClass.trim().isNotEmpty) {
      _studentClass = newClass.trim();
    }
    if (newFocus.trim().isNotEmpty) {
      _learningFocus = newFocus.trim();
    }
    notifyListeners();
    await _save();
  }

  Future<void> updateAvatar(int index) async {
    if (index < 0 || index >= kAvatarOptions.length) return;
    _avatarIndex = index;
    notifyListeners();
    await _save();
  }

  /// Return true kalau password lama cocok & berhasil diganti.
  bool changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    if (oldPassword != _password) return false;
    _password = newPassword;
    notifyListeners();
    _save();
    return true;
  }
}