import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Search bar untuk filter modul. State (controller & callback) dipegang
/// oleh parent (HomePage) supaya widget ini tetap stateless & reusable.
class ModuleSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  const ModuleSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate300),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.manage_search, color: AppColors.sky600, size: 20),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari materi, jenis bug, sintaks (TypeError, loop)...',
                hintStyle: TextStyle(color: AppColors.slate400, fontSize: 13),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
              style: const TextStyle(fontSize: 13, color: AppColors.slate800),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: AppColors.slate100, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.tune, size: 18, color: AppColors.slate600),
            ),
          ),
        ],
      ),
    );
  }
}
