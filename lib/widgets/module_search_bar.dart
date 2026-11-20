import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'glass_morphism_box.dart';

/// Search bar kapsul Liquid Glass membulat penuh.
class ModuleSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  ModuleSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: GlassMorphismBox(
        borderRadius: 999,
        opacity: 0.48,
        padding: EdgeInsets.only(left: 14, right: 6),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: AppColors.sky600, size: 20),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cari materi, bug, atau sintaks...',
                  hintStyle: TextStyle(color: AppColors.slate400, fontSize: 13),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
                style: TextStyle(fontSize: 13, color: AppColors.slate800),
              ),
            ),
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.slate200),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate900.withOpacity(0.06),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.tune_rounded,
                  size: 17,
                  color: AppColors.sky600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}