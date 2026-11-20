import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../../pages/splash_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/theme_controller.dart';

/// Menampilkan jendela kartu profil pelajar mengambang di pojok kanan atas.
void showProfileSettingsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(AppColors.isDark ? 0.48 : 0.24),
    barrierDismissible: true,
    barrierLabel: 'Pengaturan Profil',
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const Align(
        alignment: Alignment.topRight,
        child: _ProfileFloatingCard(),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          alignment: Alignment.topRight,
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: child,
        ),
      );
    },
  );
}

class _ProfileFloatingCard extends StatefulWidget {
  const _ProfileFloatingCard();

  @override
  State<_ProfileFloatingCard> createState() => _ProfileFloatingCardState();
}

class _ProfileFloatingCardState extends State<_ProfileFloatingCard> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _classCtrl;
  late String _selectedFocus;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final profile = UserProfile.instance;
    _nameCtrl = TextEditingController(text: profile.name);
    _classCtrl = TextEditingController(text: profile.studentClass);
    _selectedFocus = profile.learningFocus;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _classCtrl.dispose();
    super.dispose();
  }

  void _startEditing() {
    final profile = UserProfile.instance;
    _nameCtrl.text = profile.name;
    _classCtrl.text = profile.studentClass;
    _selectedFocus = profile.learningFocus;
    setState(() => _isEditing = true);
  }

  Future<void> _saveProfile() async {
    await UserProfile.instance.updateProfile(
      newName: _nameCtrl.text,
      newClass: _classCtrl.text,
      newFocus: _selectedFocus,
    );
    if (!mounted) return;
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profil pelajar berhasil diperbarui'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        UserProfile.instance,
        ThemeController.instance,
      ]),
      builder: (context, _) {
        final isDark = AppColors.isDark;
        final profile = UserProfile.instance;
        final avatar = profile.avatar;

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 64, right: 16, left: 16),
            constraints: const BoxConstraints(maxWidth: 325, maxHeight: 610),
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                const Color(0xFF131B2E).withOpacity(0.82),
                                const Color(0xFF0F172A).withOpacity(0.76),
                                const Color(0xFF1E1B4B).withOpacity(0.80),
                              ]
                            : [
                                const Color(0xFFF1F5FB).withOpacity(0.92),
                                const Color(0xFFE6ECF7).withOpacity(0.88),
                                const Color(0xFFDCE4F5).withOpacity(0.90),
                              ],
                      ),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.22)
                            : Colors.white.withOpacity(0.85),
                        width: 1.4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.42 : 0.14),
                          blurRadius: 26,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // --- 1. Banner Gradasi + Avatar Overlapping ---
                          _buildBannerHeader(context, profile, avatar, isDark),

                          // --- 2. Identitas atau Form Edit ---
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (_isEditing)
                                  _buildEditForm(isDark)
                                else
                                  _buildIdentityView(profile, isDark),

                                const SizedBox(height: 16),

                                // --- 3. Pemilih Avatar ---
                                _buildAvatarSection(profile, isDark),

                                const SizedBox(height: 14),

                                // --- 4. Pintasan Mode Tampilan ---
                                _buildQuickThemeTile(isDark),

                                const SizedBox(height: 14),

                                // --- 5. Tombol Ubah Password & Keluar ---
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _showChangePasswordDialog(context);
                                        },
                                        icon: const Icon(
                                          Icons.lock_reset_rounded,
                                          size: 17,
                                        ),
                                        label: const Text(
                                          'Password',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 11,
                                          ),
                                          backgroundColor: isDark
                                              ? AppColors.sky600
                                                  .withOpacity(0.14)
                                              : Colors.white.withOpacity(0.55),
                                          foregroundColor: AppColors.sky700,
                                          side: BorderSide(
                                            color: AppColors.sky600
                                                .withOpacity(0.55),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _showLogoutConfirmDialog(context);
                                        },
                                        icon: const Icon(
                                          Icons.logout_rounded,
                                          size: 16,
                                        ),
                                        label: const Text(
                                          'Keluar',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 11,
                                          ),
                                          backgroundColor: isDark
                                              ? const Color(0xFF4C0519)
                                                  .withOpacity(0.45)
                                              : const Color(0xFFFFE4E6)
                                                  .withOpacity(0.80),
                                          foregroundColor: isDark
                                              ? AppColors.rose300
                                              : const Color(0xFFBE123C),
                                          side: BorderSide(
                                            color: isDark
                                                ? AppColors.rose400
                                                    .withOpacity(0.40)
                                                : const Color(0xFFFDA4AF),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBannerHeader(
    BuildContext context,
    UserProfile profile,
    AvatarOption avatar,
    bool isDark,
  ) {
    return SizedBox(
      height: 112,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Banner atas mengikuti warna gradasi avatar
          Container(
            height: 76,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  avatar.gradient.first.withOpacity(isDark ? 0.75 : 0.88),
                  avatar.gradient.last.withOpacity(isDark ? 0.85 : 0.95),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Badge NIS Siswa
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.32),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        profile.studentId,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tombol tutup popup
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.24),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.32),
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Avatar utama di tengah bawah banner
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: avatar.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: isDark ? const Color(0xFF131B2E) : Colors.white,
                        width: 3.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: avatar.gradient.first.withOpacity(0.38),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      avatar.icon,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  // Lencana Level di pojok avatar
                  Positioned(
                    bottom: -2,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sky600,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color:
                              isDark ? const Color(0xFF131B2E) : Colors.white,
                          width: 1.8,
                        ),
                      ),
                      child: const Text(
                        'Lv. 4',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityView(UserProfile profile, bool isDark) {
    return Column(
      children: [
        Text(
          profile.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          profile.email,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.5,
            color: AppColors.slate500,
          ),
        ),
        const SizedBox(height: 10),

        // Chip Kelas & Fokus Belajar
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: [
            _infoPill(
              icon: Icons.school_rounded,
              label: profile.studentClass,
              isDark: isDark,
            ),
            _infoPill(
              icon: Icons.track_changes_rounded,
              label: profile.learningFocus,
              isDark: isDark,
              isAccent: true,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Tombol Edit Profil rapi
        SizedBox(
          height: 34,
          child: OutlinedButton.icon(
            onPressed: _startEditing,
            icon: const Icon(Icons.edit_rounded, size: 14),
            label: const Text(
              'Edit Identitas & Fokus',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              backgroundColor: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.white.withOpacity(0.65),
              foregroundColor: AppColors.slate800,
              side: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.18)
                    : AppColors.slate300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoPill({
    required IconData icon,
    required String label,
    required bool isDark,
    bool isAccent = false,
  }) {
    final bgColor = isAccent
        ? AppColors.sky600.withOpacity(isDark ? 0.22 : 0.12)
        : (isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.white.withOpacity(0.68));
    final fgColor = isAccent ? AppColors.sky700 : AppColors.slate700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isAccent
              ? AppColors.sky600.withOpacity(0.35)
              : (isDark
                  ? Colors.white.withOpacity(0.14)
                  : AppColors.slate200),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.5, color: fgColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: fgColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(bool isDark) {
    final fieldFill = isDark
        ? const Color(0xFF090D16).withOpacity(0.60)
        : Colors.white.withOpacity(0.80);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.16)
              : Colors.white.withOpacity(0.85),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Ubah Identitas Siswa',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: AppColors.slate800,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            autofocus: true,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.slate900,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: fieldFill,
              labelText: 'Nama Lengkap',
              labelStyle: TextStyle(fontSize: 11.5, color: AppColors.slate500),
              prefixIcon: const Icon(Icons.person_outline_rounded, size: 17),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _classCtrl,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.slate900,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: fieldFill,
              labelText: 'Kelas / Jurusan',
              labelStyle: TextStyle(fontSize: 11.5, color: AppColors.slate500),
              prefixIcon: const Icon(Icons.school_outlined, size: 17),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Fokus Belajar Saat Ini',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.slate600,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: kLearningFocusOptions.map((focus) {
              final selected = _selectedFocus == focus;
              return GestureDetector(
                onTap: () => setState(() => _selectedFocus = focus),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.sky600
                        : (isDark
                            ? Colors.white.withOpacity(0.07)
                            : Colors.white.withOpacity(0.75)),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selected
                          ? AppColors.sky600
                          : AppColors.slate300.withOpacity(0.6),
                    ),
                  ),
                  child: Text(
                    focus,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : AppColors.slate700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() => _isEditing = false),
                  child: Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.slate600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.check_rounded, size: 16),
                  label: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sky600,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildAvatarSection(UserProfile profile, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.14)
              : Colors.white.withOpacity(0.85),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Avatar Coding',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate800,
                ),
              ),
              Text(
                '${profile.avatarIndex + 1}/${kAvatarOptions.length}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kAvatarOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final option = kAvatarOptions[index];
              final selected = index == profile.avatarIndex;
              return GestureDetector(
                onTap: () => profile.updateAvatar(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: option.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: selected
                          ? Colors.white
                          : (isDark
                              ? Colors.white.withOpacity(0.24)
                              : Colors.white.withOpacity(0.75)),
                      width: selected ? 2.6 : 1.5,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: option.gradient.first.withOpacity(0.50),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        option.icon,
                        color: Colors.white,
                        size: 18,
                      ),
                      if (selected)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.emerald500,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.4,
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickThemeTile(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.14)
              : Colors.white.withOpacity(0.85),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.sky600.withOpacity(0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: 17,
              color: AppColors.sky600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDark ? 'Mode Gelap Nyaman' : 'Mode Terang Teduh',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
                Text(
                  'Tersimpan otomatis',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.slate500,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isDark,
            activeColor: AppColors.sky600,
            onChanged: (val) => ThemeController.instance.setDark(val),
          ),
        ],
      ),
    );
  }
}

void _showLogoutConfirmDialog(BuildContext context) {
  final isDark = AppColors.isDark;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: isDark ? const Color(0xFF131B2E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isDark ? Colors.white.withOpacity(0.18) : Colors.transparent,
        ),
      ),
      title: Text(
        'Keluar dari Akun?',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 17,
          color: AppColors.slate900,
        ),
      ),
      content: Text(
        'Progres belajar dan pengaturan profil tetap tersimpan di perangkat ini.',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.slate600,
          height: 1.45,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text('Batal', style: TextStyle(color: AppColors.slate500)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE11D48),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.pop(dialogContext);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => SplashPage()),
              (route) => false,
            );
          },
          child: const Text(
            'Keluar',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

void _showChangePasswordDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool obscureOld = true, obscureNew = true, obscureConfirm = true;
  final isDark = AppColors.isDark;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: isDark ? const Color(0xFF131B2E) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.18)
                    : Colors.transparent,
              ),
            ),
            title: Text(
              'Ubah Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.slate900,
              ),
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldCtrl,
                    obscureText: obscureOld,
                    style: TextStyle(color: AppColors.slate900),
                    decoration: InputDecoration(
                      labelText: 'Password Lama',
                      prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureOld ? Icons.visibility_off : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () =>
                            setDialogState(() => obscureOld = !obscureOld),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: newCtrl,
                    obscureText: obscureNew,
                    style: TextStyle(color: AppColors.slate900),
                    decoration: InputDecoration(
                      labelText: 'Password Baru',
                      prefixIcon: const Icon(Icons.lock_reset, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureNew ? Icons.visibility_off : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () =>
                            setDialogState(() => obscureNew = !obscureNew),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Wajib diisi';
                      if (v.length < 6) return 'Minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmCtrl,
                    obscureText: obscureConfirm,
                    style: TextStyle(color: AppColors.slate900),
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password Baru',
                      prefixIcon: const Icon(
                        Icons.check_circle_outline,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () => setDialogState(
                          () => obscureConfirm = !obscureConfirm,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Wajib diisi';
                      if (v != newCtrl.text) return 'Konfirmasi tidak cocok';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  'Batal',
                  style: TextStyle(color: AppColors.slate500),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sky600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  final success = UserProfile.instance.changePassword(
                    oldPassword: oldCtrl.text,
                    newPassword: newCtrl.text,
                  );
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Password berhasil diubah!'
                            : 'Password lama salah',
                      ),
                      backgroundColor: success
                          ? Colors.green.shade600
                          : Colors.red.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}