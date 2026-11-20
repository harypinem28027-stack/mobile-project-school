import 'package:flutter/material.dart';

import '../models/learning_module.dart';
import '../theme/app_colors.dart';
import 'glass_morphism_box.dart';
import 'meta_badge.dart';

class ModuleCard extends StatelessWidget {
  final LearningModule module;
  final VoidCallback? onTap;

  const ModuleCard({super.key, required this.module, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark;

    return GlassMorphismBox(
      borderRadius: 28,
      opacity: 0.46,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          splashColor: AppColors.sky600.withOpacity(0.08),
          highlightColor: Colors.white.withOpacity(isDark ? 0.08 : 0.25),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: module.iconBg.withOpacity(isDark ? 0.22 : 0.90),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? module.iconColor.withOpacity(0.45)
                              : module.iconBorder,
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        module.icon,
                        color: module.iconColor,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.code,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate900,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            module.idMateri,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 6,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.emerald50.withOpacity(0.90),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.emerald200),
                          ),
                          child: Text(
                            module.level,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.emerald700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B).withOpacity(0.85)
                                : Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: 13,
                                color: AppColors.slate600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                module.duration,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.slate600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  module.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14.5,
                    color: AppColors.slate900,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  module.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.slate600,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0xFF090D16).withOpacity(0.96),
                              const Color(0xFF111827).withOpacity(0.92),
                            ]
                          : [
                              const Color(0xFF0F172A).withOpacity(0.94),
                              const Color(0xFF1E293B).withOpacity(0.90),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(isDark ? 0.14 : 0.22),
                      width: 1.1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        module.bugIcon,
                        size: 15,
                        color: module.bugIconColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          module.bugSnippet,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: module.bugTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF022C22).withOpacity(0.90),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.45),
                          ),
                        ),
                        child: Text(
                          module.caseCount,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6EE7B7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.slate200, width: 1),
                    ),
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
                      GlassMorphismBox(
                        borderRadius: 999,
                        opacity: 0.65,
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: AppColors.sky600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}