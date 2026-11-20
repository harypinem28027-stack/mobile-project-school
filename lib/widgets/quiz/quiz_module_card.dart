import 'package:flutter/material.dart';

import '../../models/quiz.dart';
import '../../theme/app_colors.dart';
import '../glass_morphism_box.dart';

/// Kartu satu modul kuis bergaya Liquid Glass membulat.
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
    return GlassMorphismBox(
      borderRadius: 28,
      opacity: 0.46,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(),
          const SizedBox(height: 12),
          _buildDetailChips(),
          const SizedBox(height: 12),
          _buildTopicBox(),
          const SizedBox(height: 14),
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
                  Text(
                    module.materialId,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: module.accentColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _statusBadge(),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                module.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
              ),
            ],
          ),
        ),
        if (module.status != QuizStatus.newChallenge) _scoreColumn(),
      ],
    );
  }

  Widget _statusBadge() {
    final isDark = AppColors.isDark;
    switch (module.status) {
      case QuizStatus.completed:
        return _pill(
          'STATUS: SELESAI',
          bg: AppColors.emerald50.withOpacity(0.92),
          fg: AppColors.emerald700,
          border: AppColors.emerald200,
        );
      case QuizStatus.newChallenge:
        return _pill(
          'TANTANGAN BARU',
          bg: AppColors.sky600,
          fg: Colors.white,
          border: AppColors.sky600,
        );
      case QuizStatus.needsImprovement:
        return _pill(
          'EVALUASI DRAF',
          bg: isDark
              ? const Color(0xFF1E293B).withOpacity(0.9)
              : Colors.white.withOpacity(0.75),
          fg: AppColors.slate700,
          border: AppColors.slate200,
        );
    }
  }

  Widget _pill(
    String text, {
    required Color bg,
    required Color fg,
    required Color border,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          color: fg,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _scoreColumn() {
    final color = module.status == QuizStatus.completed
        ? AppColors.emerald700
        : AppColors.sky700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text.rich(
          TextSpan(
            text: '${module.score}',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1,
            ),
            children: [
              TextSpan(
                text: '/100',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.slate500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Text(
          module.status == QuizStatus.completed
              ? '${module.correctCount}/${module.totalQuestions} Benar'
              : 'Perlu Peningkatan',
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailChips() {
    final chips = <Widget>[
      _detailChip(
        Icons.format_list_numbered_rounded,
        '${module.totalQuestions} Butir Soal',
      ),
      _detailChip(
        Icons.timer_outlined,
        'Est. ${module.estimatedMinutes} Menit',
      ),
    ];
    if (module.status == QuizStatus.newChallenge) {
      chips.add(
        _detailChip(
          Icons.new_releases_rounded,
          'Belum Dikerjakan',
          color: AppColors.sky600,
        ),
      );
    } else {
      chips.add(_detailChip(Icons.flag_rounded, 'KKM ${module.kkmPercent}%'));
    }
    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }

  Widget _detailChip(IconData icon, String label, {Color? color}) {
    final isDark = AppColors.isDark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E293B).withOpacity(0.75)
            : Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.slate200.withOpacity(0.9)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? AppColors.slate600),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color ?? AppColors.slate700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicBox() {
    final isDark = AppColors.isDark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0F172A).withOpacity(0.65)
            : Colors.white.withOpacity(0.46),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.slate200.withOpacity(0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            module.topicLabel.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.slate500,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          if (module.topicChips.isNotEmpty)
            Wrap(
              spacing: 5,
              runSpacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...module.topicChips.map(
                  (c) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : Colors.white.withOpacity(0.82),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.sky700 : AppColors.slate800,
                      ),
                    ),
                  ),
                ),
                if (module.topicNote != null)
                  Text(
                    module.topicNote!,
                    style: TextStyle(fontSize: 11.5, color: AppColors.slate600),
                  ),
              ],
            )
          else if (module.topicNote != null)
            Text(
              module.topicNote!,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.slate700,
                height: 1.45,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final isDark = AppColors.isDark;
    switch (module.status) {
      case QuizStatus.completed:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.history_edu_rounded, size: 17),
                label: const Text(
                  'Pembahasan',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xFF1E293B).withOpacity(0.82)
                      : Colors.white.withOpacity(0.55),
                  foregroundColor: AppColors.slate700,
                  side: BorderSide(color: AppColors.slate200),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.replay_rounded, size: 17),
                label: const Text(
                  'Ulangi Kuis',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.sky50.withOpacity(0.85),
                  foregroundColor: AppColors.sky700,
                  side: BorderSide(color: AppColors.sky200),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
        );
      case QuizStatus.newChallenge:
        return Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.sky600, const Color(0xFF6366F1)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.sky600.withOpacity(0.28),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: onStart,
            icon: const Text(
              'Mulai Kuis',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            label: const Icon(Icons.arrow_forward_rounded, size: 18),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        );
      case QuizStatus.needsImprovement:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.upgrade_rounded, size: 18),
            label: const Text(
              'Perbaiki Nilai',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: isDark
                  ? const Color(0xFF1E293B).withOpacity(0.85)
                  : Colors.white.withOpacity(0.65),
              foregroundColor: AppColors.sky700,
              side: BorderSide(color: AppColors.sky200, width: 1.3),
              padding: const EdgeInsets.symmetric(vertical: 11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        );
    }
  }
}