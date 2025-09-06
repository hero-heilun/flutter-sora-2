import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../providers/tmdb_provider.dart';
import '../../services/tmdb_service.dart';
import '../../core/utils/search_algorithms.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String _selectedLanguage = 'en-US';
  SearchAlgorithm _selectedAlgorithm = SearchAlgorithm.hybrid;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('tmdb_language') ?? 'en-US';
      final algorithmIndex = prefs.getInt('search_algorithm') ?? 0;
      _selectedAlgorithm = SearchAlgorithm.values[algorithmIndex];
    });
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tmdb_language', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
    ref.read(tmdbProvider.notifier).setLanguage(languageCode);
  }

  Future<void> _saveAlgorithm(SearchAlgorithm algorithm) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('search_algorithm', algorithm.index);
    setState(() {
      _selectedAlgorithm = algorithm;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TMDB Settings Section
            const Text(
              'TMDB Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Language Setting
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Text(_getLanguageName(_selectedLanguage)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showLanguageDialog,
            ),
            
            // Algorithm Setting
            ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Search Algorithm'),
              subtitle: Text(_getAlgorithmName(_selectedAlgorithm)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showAlgorithmDialog,
            ),
            
            const Divider(height: 40),
            
            // Services Management Section
            const Text(
              'Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Services Manager Entry
            ListTile(
              leading: const Icon(Icons.settings_applications),
              title: const Text('Services Manager'),
              subtitle: const Text('Add, manage and configure streaming services'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.push('/services-manager'),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    final language = TMDBService.supportedLanguages
        .firstWhere((lang) => lang['code'] == code, orElse: () => {'name': code});
    return language['name']!;
  }

  String _getAlgorithmName(SearchAlgorithm algorithm) {
    switch (algorithm) {
      case SearchAlgorithm.hybrid:
        return 'Hybrid (Recommended)';
      case SearchAlgorithm.jaroWinkler:
        return 'Jaro-Winkler';
      case SearchAlgorithm.levenshtein:
        return 'Levenshtein Distance';
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: TMDBService.supportedLanguages.length,
            itemBuilder: (context, index) {
              final language = TMDBService.supportedLanguages[index];
              final isSelected = language['code'] == _selectedLanguage;
              
              return ListTile(
                title: Text(language['name']!),
                trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
                onTap: () {
                  _saveLanguage(language['code']!);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAlgorithmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Search Algorithm'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SearchAlgorithm.values.map((algorithm) {
            final isSelected = algorithm == _selectedAlgorithm;
            return ListTile(
              title: Text(_getAlgorithmName(algorithm)),
              subtitle: Text(_getAlgorithmDescription(algorithm)),
              trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
              onTap: () {
                _saveAlgorithm(algorithm);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  String _getAlgorithmDescription(SearchAlgorithm algorithm) {
    switch (algorithm) {
      case SearchAlgorithm.hybrid:
        return 'Combines multiple algorithms for best results';
      case SearchAlgorithm.jaroWinkler:
        return 'Good for short strings with similar prefixes';
      case SearchAlgorithm.levenshtein:
        return 'Measures character-level differences';
    }
  }

}