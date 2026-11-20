import 'package:flutter/material.dart';
import 'package:mobile_project/data/user_profile.dart';

import '../data/module_data.dart';
import '../models/learning_module.dart';
import '../widgets/active_module_card.dart';
import '../widgets/category_pills.dart';
import '../widgets/greeting_section.dart';
import '../widgets/main_scaffold.dart';
import '../widgets/module_card.dart';
import '../widgets/module_search_bar.dart';
import '../widgets/teacher_banner_card.dart';
import '../widgets/tips_card.dart';

/// Halaman Dashboard/Home (tab index 0 "Modul") - GPU Optimized.
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 820),
    );

    // Tunggu frame pertama selesai dirender agar animasi geser tidak terpotong lag
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });

    UserProfile.instance.addListener(_onProfileChanged);
  }

  void _onProfileChanged() {
    if (mounted) setState(() {});
  }

  List<LearningModule> get _filteredModules {
    return kModules.where((m) {
      final matchCat =
          _selectedCategory == 'all' || m.category == _selectedCategory;
      final matchKeyword = _searchQuery.isEmpty ||
          m.searchHaystack.contains(_searchQuery.toLowerCase());
      return matchCat && matchKeyword;
    }).toList();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    UserProfile.instance.removeListener(_onProfileChanged);
    _searchController.dispose();
    super.dispose();
  }

  /// Animasi geser kanan-ke-kiri ringan tanpa Opacity saveLayer (ramah GPU HP/Laptop).
  Widget _slideRightToLeft({
    required double start,
    required double end,
    required Widget child,
    double slideDistance = 72.0,
  }) {
    final curve = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(
        start.clamp(0.0, 0.90),
        end.clamp(0.10, 1.0),
        curve: Curves.easeOutQuart,
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: curve,
        child: child,
        builder: (context, cachedChild) {
          final offsetX = (1.0 - curve.value) * slideDistance;
          return Transform.translate(
            offset: Offset(offsetX, 0),
            child: cachedChild,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modules = _filteredModules;
    final profileName = UserProfile.instance.name.trim();
    final displayName = profileName.isEmpty
        ? 'Siswa'
        : profileName.split(RegExp(r'\s+')).first;
    final bottomSpace = MediaQuery.of(context).padding.bottom + 104;

    return MainScaffold(
      currentIndex: 0,
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomSpace),
        children: [
          _slideRightToLeft(
            start: 0.00,
            end: 0.44,
            slideDistance: 60,
            child: GreetingSection(userName: displayName),
          ),
          SizedBox(height: 16),
          _slideRightToLeft(
            start: 0.07,
            end: 0.50,
            slideDistance: 72,
            child: TeacherBannerCard(),
          ),
          SizedBox(height: 16),
          _slideRightToLeft(
            start: 0.14,
            end: 0.56,
            slideDistance: 84,
            child: ModuleSearchBar(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.trim()),
            ),
          ),
          SizedBox(height: 16),
          _slideRightToLeft(
            start: 0.21,
            end: 0.62,
            slideDistance: 96,
            child: ActiveModuleCard(),
          ),
          SizedBox(height: 20),
          _slideRightToLeft(
            start: 0.28,
            end: 0.68,
            slideDistance: 100,
            child: CategoryPills(
              selectedValue: _selectedCategory,
              onSelected: (v) => setState(() => _selectedCategory = v),
            ),
          ),
          SizedBox(height: 14),
          if (modules.isEmpty)
            _slideRightToLeft(
              start: 0.34,
              end: 0.78,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'Tidak ada modul ditemukan',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
            )
          else
            ...List.generate(modules.length, (index) {
              final start = (0.34 + index * 0.08).clamp(0.0, 0.64);
              final end = (start + 0.36).clamp(0.36, 1.0);

              return _slideRightToLeft(
                start: start,
                end: end,
                slideDistance: 110,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: ModuleCard(module: modules[index]),
                ),
              );
            }),
          SizedBox(height: 8),
          _slideRightToLeft(
            start: 0.56,
            end: 1.00,
            slideDistance: 90,
            child: TipsCard(),
          ),
        ],
      ),
    );
  }
}