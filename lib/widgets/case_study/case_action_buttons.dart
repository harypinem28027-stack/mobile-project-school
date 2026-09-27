import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Dua tombol aksi di bawah halaman studi kasus: buka Lab Test & simpan
/// ke catatan. State "tersimpan" dipegang parent lewat [isSaved] +
/// [onToggleSave], supaya widget ini tetap stateless & reusable.
class CaseActionButtons extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onOpenLab;
  final VoidCallback onToggleSave;

  const CaseActionButtons({
    super.key,
    required this.isSaved,
    required this.onOpenLab,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: onOpenLab,
            icon: const Icon(Icons.play_circle, size: 22),
            label: const Text('Buka di Lab Test', style: TextStyle(fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.sky600,
              foregroundColor: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: onToggleSave,
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
              size: 20,
              color: isSaved ? const Color(0xFF059669) : const Color(0xFFF59E0B),
            ),
            label: Text(
              isSaved ? 'Tersimpan di Catatan!' : 'Simpan ke Catatan Bug',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSaved ? AppColors.emerald700 : AppColors.slate700),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: isSaved ? AppColors.emerald50 : Colors.white,
              side: BorderSide(color: isSaved ? AppColors.emerald200 : AppColors.slate300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
