import 'package:flutter/material.dart';

import '../models/learning_module.dart';
import '../theme/app_colors.dart';
import 'meta_badge.dart';

/// Kartu satu modul pembelajaran (dipakai berulang di list HomePage).
class ModuleCard extends StatelessWidget {
  final LearningModule module;
  final VoidCallback? onTap;

  const ModuleCard({super.key, required this.module, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.slate200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: module.iconBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: module.iconBorder),
                  ),
                  child: Icon(module.icon, color: module.iconColor, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(module.code,
                          style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900)),
                      Text(module.idMateri,
                          style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: AppColors.slate500)),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 6,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.emerald50,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.emerald200.withOpacity(0.5)),
                      ),
                      child: Text(module.level,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.emerald700)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.slate100, borderRadius: BorderRadius.circular(999)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.schedule, size: 13, color: AppColors.slate600),
                          const SizedBox(width: 3),
                          Text(module.duration,
                              style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: AppColors.slate600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(module.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13.5, color: AppColors.slate900)),
            const SizedBox(height: 4),
            Text(module.description,
                style: const TextStyle(fontSize: 12, color: AppColors.slate600, height: 1.5)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.slate900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: Row(
                children: [
                  Icon(module.bugIcon, size: 15, color: module.bugIconColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      module.bugSnippet,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'monospace', fontSize: 12, color: module.bugTextColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.emerald950.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF065F46).withOpacity(0.8)),
                    ),
                    child: Text(module.caseCount,
                        style: const TextStyle(
                            fontFamily: 'monospace', fontSize: 10, color: Color(0xFF6EE7B7))),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.slate100)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        MetaBadge(text: module.quizCount),
                        MetaBadge(text: module.labCount),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: AppColors.slate100, borderRadius: BorderRadius.circular(999)),
                    child: const Icon(Icons.arrow_forward, size: 18, color: AppColors.slate700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
