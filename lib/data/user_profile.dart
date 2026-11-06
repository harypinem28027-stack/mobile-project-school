import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Satu opsi avatar: ikon + warna gradasi.
class AvatarOption {
  final IconData icon;
  final List<Color> gradient;
  const AvatarOption(this.icon, this.gradient);
}

/// 10 avatar bertema coding/IT, biar nyambung sama DebugTIK.
const List<AvatarOption> kAvatarOptions = [
  AvatarOption(Icons.terminal, [Color(0xFF0EA5E9), Color(0xFF0369A1)]),
  AvatarOption(Icons.bug_report, [Color(0xFFF43F5E), Color(0xFFBE123C)]),
  AvatarOption(Icons.code, [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
  AvatarOption(Icons.memory, [Color(0xFF10B981), Color(0xFF047857)]),
  AvatarOption(Icons.data_object, [Color(0xFFF59E0B), Color(0xFFB45309)]),
  AvatarOption(Icons.smart_toy, [Color(0xFF6366F1), Color(0xFF4338CA)]),
  AvatarOption(Icons.rocket_launch, [Color(0xFFEC4899), Color(0xFFBE185D)]),
  AvatarOption(Icons.auto_awesome, [Color(0xFF14B8A6), Color(0xFF0F766E)]),
  AvatarOption(Icons.developer_mode, [Color(0xFF64748B), Color(0xFF334155)]),
  AvatarOption(Icons.integration_instructions, [Color(0xFF22C55E), Color(0xFF15803D)]),
];

/// Data profil global & reaktif (ChangeNotifier) + disimpan permanen.
class UserProfile extends ChangeNotifier {
  UserProfile._internal();
  static final UserProfile instance = UserProfile._internal();

  static const _kName = 'profile_name';
  static const _kEmail = 'profile_email';
  static const _kAvatar = 'profile_avatar_index';

  String _name = 'Alifia Putri';
  String _email = 'alifia.putri@sekolah.sch.id';
  int _avatarIndex = 0;
  String _password = 'password123'; // DEMO ONLY

  String get name => _name;
  String get email => _email;
  int get avatarIndex => _avatarIndex;
  AvatarOption get avatar => kAvatarOptions[_avatarIndex];

  /// Dipanggil sekali saat aplikasi start (di main.dart).
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_kName) ?? _name;
    _email = prefs.getString(_kEmail) ?? _email;
    final i = prefs.getInt(_kAvatar);
    if (i != null && i >= 0 && i < kAvatarOptions.length) _avatarIndex = i;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = await Future.wait([
      prefs.setString(_kName, _name),
      prefs.setString(_kEmail, _email),
      prefs.setInt(_kAvatar, _avatarIndex),
    ]);
    if (saved.any((success) => !success)) {
      throw StateError('Gagal menyimpan perubahan profil.');
    }
  }

  Future<void> updateName(String newName) async {
    if (newName.trim().isEmpty) return;
    _name = newName.trim();
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
  bool changePassword({required String oldPassword, required String newPassword}) {
    if (oldPassword != _password) return false;
    _password = newPassword;
    notifyListeners();
    return true;
  }
}