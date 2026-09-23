import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    super.key,
    required this.sky,
    required this.slate700,
  });

  final Color sky;
  final Color slate700;

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka Lab Praktik...'),
                ),
              );
            },
            icon: const Icon(
              Icons.play_circle,
              size: 22,
            ),
            label: const Text(
              'Buka di Lab Praktik',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.sky,
              foregroundColor: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSaved
                        ? 'Bug berhasil disimpan ke catatan!'
                        : 'Bug dihapus dari catatan.',
                  ),
                ),
              );
            },
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
              size: 20,
              color: isSaved
                  ? const Color(0xFF059669)
                  : const Color(0xFFF59E0B),
            ),
            label: Text(
              isSaved ? 'Tersimpan di Catatan!' : 'Simpan ke Catatan Bug',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSaved ? const Color(0xFF047857) : widget.slate700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  isSaved ? const Color(0xFFECFDF5) : Colors.white,
              side: BorderSide(
                color: isSaved
                    ? const Color(0xFFA7F3D0)
                    : const Color(0xFFCBD5E1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
