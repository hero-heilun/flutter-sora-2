import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/app_state_provider.dart';
import '../providers/tmdb_provider.dart';
import '../../services/service_manager.dart';
import '../../services/tmdb_service.dart';
import '../../core/utils/search_algorithms.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final TextEditingController _urlController = TextEditingController();
  bool _isAddingService = false;
  String _errorMessage = '';
  String _selectedLanguage = 'en-US';
  SearchAlgorithm _selectedAlgorithm = SearchAlgorithm.hybrid;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    // Pre-fill with iyinghua service URL for testing
    _urlController.text = 'https://raw.githubusercontent.com/hero-heilun/sources/refs/heads/main/iyinghua/iyinghua.json';
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

  Future<void> _addService() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    setState(() {
      _isAddingService = true;
      _errorMessage = '';
    });

    try {
      await ref.read(servicesProvider.notifier).addService(url);
      setState(() {
        _isAddingService = false;
      });
      _urlController.clear();
      _showSuccessDialog('Service added successfully!');
    } catch (e) {
      setState(() {
        _isAddingService = false;
        _errorMessage = 'Failed to add service: $e';
      });
    }
  }

  Future<void> _setActiveService(String serviceId) async {
    try {
      await ref.read(servicesProvider.notifier).setActiveService(serviceId);
      final service = ref.read(servicesProvider).firstWhere((s) => s.id == serviceId);
      _showSuccessDialog('Service ${service.isActive ? "activated" : "deactivated"} successfully!');
    } catch (e) {
      _showErrorDialog('Failed to toggle service: $e');
    }
  }

  Future<void> _setPrimaryService(String serviceId) async {
    try {
      await ServiceManager.instance.setPrimaryService(serviceId);
      _showSuccessDialog('Primary service set successfully!');
    } catch (e) {
      _showErrorDialog('Failed to set primary service: $e');
    }
  }

  Future<void> _removeService(String serviceId) async {
    try {
      await ref.read(servicesProvider.notifier).removeService(serviceId);
      _showSuccessDialog('Service removed successfully!');
    } catch (e) {
      _showErrorDialog('Failed to remove service: $e');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRemoveConfirmDialog(Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Service'),
        content: Text('Are you sure you want to remove "${service.metadata.sourceName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeService(service.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
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
            
            // Add Service Section
            const Text(
              'Add New Service',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Service JSON URL',
                hintText: 'https://example.com/service.json',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              enabled: !_isAddingService,
            ),
            const SizedBox(height: 8),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAddingService ? null : _addService,
                child: _isAddingService
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Add Service'),
              ),
            ),
            const SizedBox(height: 32),

            // Services List Section
            const Text(
              'Available Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.green[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Activate multiple services to enable multi-service search. The primary service (★) is used for main browsing.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ref.watch(servicesProvider).isEmpty
                  ? const Center(
                      child: Text(
                        'No services added yet.\nAdd a service using the form above.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: ref.watch(servicesProvider).length,
                      itemBuilder: (context, index) {
                        final services = ref.watch(servicesProvider);
                        final service = services[index];
                        final isActive = service.isActive;
                        final isPrimary = ref.watch(servicesProvider.notifier).activeService?.id == service.id;
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: isActive ? Colors.green.withValues(alpha: 0.1) : null,
                          child: ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(service.metadata.iconUrl),
                                  onBackgroundImageError: (exception, stackTrace) {},
                                  child: service.metadata.iconUrl.isEmpty
                                      ? const Icon(Icons.movie)
                                      : null,
                                ),
                                if (isPrimary)
                                  Positioned(
                                    right: -2,
                                    top: -2,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    service.metadata.sourceName,
                                    style: TextStyle(
                                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isPrimary)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'PRIMARY',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Version: ${service.metadata.version}'),
                                Text('Language: ${service.metadata.language}'),
                                Text('Quality: ${service.metadata.quality}'),
                                Row(
                                  children: [
                                    if (isActive)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'ACTIVE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Toggle activation button
                                IconButton(
                                  icon: Icon(
                                    isActive ? Icons.pause : Icons.play_arrow,
                                    color: isActive ? Colors.red : Colors.green,
                                  ),
                                  onPressed: () => _setActiveService(service.id),
                                  tooltip: isActive ? 'Deactivate' : 'Activate',
                                ),
                                // Set as primary button (only for active services)
                                if (isActive && !isPrimary)
                                  IconButton(
                                    icon: const Icon(Icons.star_border, color: Colors.orange),
                                    onPressed: () => _setPrimaryService(service.id),
                                    tooltip: 'Set as Primary',
                                  ),
                                // Remove button
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () => _showRemoveConfirmDialog(service),
                                  tooltip: 'Remove',
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
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

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}