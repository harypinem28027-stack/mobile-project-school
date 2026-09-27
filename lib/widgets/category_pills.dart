import 'package:flutter/material.dart';

import '../data/module_data.dart';
import '../models/learning_module.dart';
import '../theme/app_colors.dart';

/// Baris pill filter kategori (Semua / HTML / CSS / JS), horizontal scroll.
class CategoryPills extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onSelected;
  final List<CategoryPill> pills;

  const CategoryPills({
    super.key,
    required this.selectedValue,
    required this.onSelected,
    this.pills = kCategoryPills,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'KATEGORI MATERI',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '${pills.length} Kategori',
              style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: AppColors.sky700,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: pills.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final pill = pills[index];
              final isActive = selectedValue == pill.value;
              return GestureDetector(
                onTap: () => onSelected(pill.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.sky600 : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: isActive ? null : Border.all(color: AppColors.slate200),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 3)],
                  ),
                  child: Text(
                    pill.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.slate700,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
