import 'package:flutter/material.dart';

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

/// Halaman Dashboard/Home (tab index 0 "Modul").
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<LearningModule> get _filteredModules {
    return kModules.where((m) {
      final matchCat = _selectedCategory == 'all' || m.category == _selectedCategory;
      final matchKeyword =
          _searchQuery.isEmpty || m.searchHaystack.contains(_searchQuery.toLowerCase());
      return matchCat && matchKeyword;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modules = _filteredModules;

    return MainScaffold(
      currentIndex: 0,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const GreetingSection(),
          const SizedBox(height: 16),
          const TeacherBannerCard(),
          const SizedBox(height: 16),
          ModuleSearchBar(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchQuery = v.trim()),
          ),
          const SizedBox(height: 16),
          const ActiveModuleCard(),
          const SizedBox(height: 20),
          CategoryPills(
            selectedValue: _selectedCategory,
            onSelected: (v) => setState(() => _selectedCategory = v),
          ),
          const SizedBox(height: 14),
          if (modules.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text('Tidak ada modul ditemukan',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
            )
          else
            ...modules.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: ModuleCard(module: m),
              ),
            ),
          const SizedBox(height: 8),
          const TipsCard(),
        ],
      ),
    );
  }
}
