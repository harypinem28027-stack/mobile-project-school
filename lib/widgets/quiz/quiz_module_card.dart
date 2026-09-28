import 'package:flutter/material.dart';

import '../../models/quiz.dart';
import '../../theme/app_colors.dart';

/// Kartu satu modul kuis. Tampilannya berbeda tergantung [QuizStatus]:
/// - completed: nilai + tombol Pembahasan/Ulangi Kuis
/// - newChallenge: badge "wajib" + tombol besar Mulai Kuis
/// - needsImprovement: nilai + tombol Perbaiki Nilai
class QuizModuleCard extends StatelessWidget {
  final QuizModule module;
  final VoidCallback onStart;
  final VoidCallback? onReview;

  const QuizModuleCard({
    super.key,
    required this.module,
    required this.onStart,
    this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    final isNew = module.status == QuizStatus.newChallenge;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isNew ? 0.06 : 0.04), blurRadius: isNew ? 10 : 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(),
          const SizedBox(height: 10),
          _buildDetailChips(),
          const SizedBox(height: 10),
          _buildTopicBox(),
          const SizedBox(height: 12),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(module.materialId,
                      style: TextStyle(
                          fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w700, color: module.accentColor)),
                  const SizedBox(width: 6),
                  _statusBadge(),
                ],
              ),
              const SizedBox(height: 3),
              Text(module.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.slate900)),
            ],
          ),
        ),
        if (module.status != QuizStatus.newChallenge) _scoreColumn(),
      ],
    );
  }

  Widget _statusBadge() {
    switch (module.status) {
      case QuizStatus.completed:
        return _pill('STATUS: SELESAI', bg: AppColors.emerald50, fg: AppColors.emerald700);
      case QuizStatus.newChallenge:
        return _pill('TANTANGAN BARU', bg: AppColors.sky600, fg: Colors.white);
      case QuizStatus.needsImprovement:
        return _pill('EVALUASI DRAF', bg: AppColors.slate100, fg: AppColors.slate700);
    }
  }

  Widget _pill(String text, {required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: fg, letterSpacing: 0.3)),
    );
  }

  Widget _scoreColumn() {
    final color = module.status == QuizStatus.completed ? AppColors.emerald700 : AppColors.sky700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text.rich(
          TextSpan(
            text: '${module.score}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color, height: 1),
            children: [
              const TextSpan(text: '/100', style: TextStyle(fontSize: 11, color: AppColors.slate500, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          module.status == QuizStatus.completed
              ? '${module.correctCount}/${module.totalQuestions} Benar'
              : 'Perlu Peningkatan',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }

  Widget _buildDetailChips() {
    final chips = <Widget>[
      _detailChip(Icons.format_list_numbered, '${module.totalQuestions} Butir Soal'),
      _detailChip(Icons.timer, 'Est. ${module.estimatedMinutes} Menit'),
    ];
    if (module.status == QuizStatus.newChallenge) {
      chips.add(_detailChip(Icons.new_releases, 'Belum Dikerjakan', color: AppColors.sky600));
    } else {
      chips.add(_detailChip(Icons.flag, 'KKM ${module.kkmPercent}%'));
    }
    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }

  Widget _detailChip(IconData icon, String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? AppColors.slate500),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color ?? AppColors.slate600)),
        ],
      ),
    );
  }

  Widget _buildTopicBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(module.topicLabel.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.slate500, letterSpacing: 0.3)),
          const SizedBox(height: 4),
          if (module.topicChips.isNotEmpty)
            Wrap(
              spacing: 4,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...module.topicChips.map(
                  (c) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(4)),
                    child: Text(c, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppColors.slate800)),
                  ),
                ),
                if (module.topicNote != null)
                  Text(module.topicNote!, style: const TextStyle(fontSize: 11, color: AppColors.slate500)),
              ],
            )
          else if (module.topicNote != null)
            Text(module.topicNote!, style: const TextStyle(fontSize: 12, color: AppColors.slate700, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildActions() {
    switch (module.status) {
      case QuizStatus.completed:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.history_edu, size: 17),
                label: const Text('Pembahasan'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.slate700,
                  side: const BorderSide(color: AppColors.slate200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.replay, size: 17),
                label: const Text('Ulangi Kuis'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.sky700,
                  side: const BorderSide(color: AppColors.slate200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        );
      case QuizStatus.newChallenge:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onStart,
            icon: const Text('Mulai Kuis', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            label: const Icon(Icons.arrow_forward, size: 17),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.sky600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        );
      case QuizStatus.needsImprovement:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.upgrade, size: 17),
            label: const Text('Perbaiki Nilai'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.sky700,
              side: const BorderSide(color: AppColors.slate200),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        );
    }
  }
}
