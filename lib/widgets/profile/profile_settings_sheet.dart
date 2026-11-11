import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:mobile_project/data/user_profile.dart';

import '../../theme/app_colors.dart';

/// Menampilkan jendela profil mengambang di pojok kanan atas,
/// tanpa membuka halaman baru.
void showProfileSettingsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.25),
    barrierDismissible: true,
    barrierLabel: 'Pengaturan Profil',
    transitionDuration: const Duration(milliseconds: 250),
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
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
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
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: UserProfile.instance.name);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    await UserProfile.instance.updateName(_nameCtrl.text);
    if (!mounted) return;
    setState(() => _isEditingName = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nama berhasil diperbarui'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70, right: 16),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              width: 280,
              constraints: const BoxConstraints(maxHeight: 520),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ListenableBuilder(
                listenable: UserProfile.instance,
                builder: (context, _) {
                  final profile = UserProfile.instance;
                  final avatar = profile.avatar;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: avatar.gradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              avatar.icon,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // --- Nama (bisa diedit langsung di sini) ---
                        if (_isEditingName)
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _nameCtrl,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onSubmitted: (_) => _saveName(),
                                ),
                              ),
                              IconButton(
                                onPressed: _saveName,
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: AppColors.sky600,
                                ),
                                tooltip: 'Simpan nama',
                              ),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  profile.name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _isEditingName = true),
                                child: const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: AppColors.slate500,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 2),
                        Text(
                          profile.email,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 18),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pilih Avatar',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // --- Grid 10 avatar ---
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: kAvatarOptions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemBuilder: (context, index) {
                            final option = kAvatarOptions[index];
                            final selected = index == profile.avatarIndex;
                            return GestureDetector(
                              onTap: () async {
                                await profile.updateAvatar(index);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: option.gradient,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.sky600
                                        : Colors.white,
                                    width: selected ? 3 : 2,
                                  ),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.sky600.withOpacity(
                                              0.4,
                                            ),
                                            blurRadius: 8,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Icon(
                                  option.icon,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showChangePasswordDialog(context);
                            },
                            icon: const Icon(Icons.lock_outline, size: 16),
                            label: const Text('Ubah Password'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.sky700,
                              side: const BorderSide(color: AppColors.sky600),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showChangePasswordDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool obscureOld = true, obscureNew = true, obscureConfirm = true;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Text(
              'Ubah Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldCtrl,
                    obscureText: obscureOld,
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
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.black54),
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
