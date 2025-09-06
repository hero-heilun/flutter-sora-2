import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/github_services_fetcher.dart';
import '../providers/app_state_provider.dart';

class BulkImportPage extends ConsumerStatefulWidget {
  const BulkImportPage({super.key});

  @override
  ConsumerState<BulkImportPage> createState() => _BulkImportPageState();
}

class _BulkImportPageState extends ConsumerState<BulkImportPage> {
  List<GitHubService> _availableServices = [];
  List<GitHubService> _selectedServices = [];
  bool _isLoading = false;
  bool _isImporting = false;
  String? _errorMessage;
  String? _successMessage;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _fetchAvailableServices();
  }

  Future<void> _fetchAvailableServices() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final services = await GitHubServicesFetcher.instance.fetchAvailableServices();
      setState(() {
        _availableServices = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch services: $e';
        _isLoading = false;
      });
    }
  }

  List<GitHubService> get _filteredServices {
    var filtered = _availableServices.where((service) {
      final matchesSearch = service.displayName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           service.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || service.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Sort by category, then by name
    filtered.sort((a, b) {
      final categoryComparison = a.category.compareTo(b.category);
      if (categoryComparison != 0) return categoryComparison;
      return a.displayName.compareTo(b.displayName);
    });

    return filtered;
  }

  List<String> get _availableCategories {
    final categories = _availableServices.map((s) => s.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  void _toggleService(GitHubService service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service);
      } else {
        _selectedServices.add(service);
      }
    });
  }

  void _selectAllFiltered() {
    setState(() {
      final filteredServices = _filteredServices;
      for (final service in filteredServices) {
        if (!_selectedServices.contains(service)) {
          _selectedServices.add(service);
        }
      }
    });
  }

  void _deselectAll() {
    setState(() {
      _selectedServices.clear();
    });
  }

  void _selectByCategory(String category) {
    setState(() {
      final categoryServices = _availableServices.where((s) => s.category == category).toList();
      for (final service in categoryServices) {
        if (!_selectedServices.contains(service)) {
          _selectedServices.add(service);
        }
      }
    });
  }

  Future<void> _importSelectedServices() async {
    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one service to import')),
      );
      return;
    }

    setState(() {
      _isImporting = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Import services one by one using existing service manager
      int successCount = 0;
      int failCount = 0;
      
      for (final service in _selectedServices) {
        try {
          await ref.read(servicesProvider.notifier).addService(service.configUrl);
          successCount++;
        } catch (e) {
          failCount++;
        }
        
        // Update progress
        setState(() {
          _successMessage = 'Imported $successCount/${_selectedServices.length} services...';
        });
      }

      setState(() {
        _successMessage = 'Successfully imported $successCount services' + 
                         (failCount > 0 ? ' ($failCount failed)' : '');
        _selectedServices.clear();
        _isImporting = false;
      });

      if (successCount > 0) {
        // Show success dialog
        _showResultDialog(
          'Import Completed',
          'Successfully imported $successCount services' + 
          (failCount > 0 ? '\n$failCount services failed to import' : ''),
          Icons.check_circle,
          Colors.green,
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Import failed: $e';
        _isImporting = false;
      });
    }
  }

  void _showResultDialog(String title, String message, IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Import Services'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_selectedServices.isNotEmpty)
            TextButton(
              onPressed: _isImporting ? null : _importSelectedServices,
              child: _isImporting 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Import (${_selectedServices.length})'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                
                // Category Filter and Quick Actions
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _availableCategories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        switch (value) {
                          case 'select_all':
                            _selectAllFiltered();
                            break;
                          case 'deselect_all':
                            _deselectAll();
                            break;
                          case 'select_anime':
                            _selectByCategory('Anime');
                            break;
                          case 'select_movies':
                            _selectByCategory('Movies');
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'select_all',
                          child: Text('Select All Visible'),
                        ),
                        const PopupMenuItem(
                          value: 'deselect_all',
                          child: Text('Deselect All'),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'select_anime',
                          child: Text('Select All Anime'),
                        ),
                        const PopupMenuItem(
                          value: 'select_movies',
                          child: Text('Select All Movies'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Messages
          if (_successMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green.withValues(alpha: 0.1),
              child: Text(
                _successMessage!,
                style: TextStyle(color: Colors.green[700]),
                textAlign: TextAlign.center,
              ),
            ),
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.red.withValues(alpha: 0.1),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red[700]),
                textAlign: TextAlign.center,
              ),
            ),

          // Services List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Fetching available services...'),
                      ],
                    ),
                  )
                : _availableServices.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text(
                              'No services available',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _fetchAvailableServices,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredServices.length,
                        itemBuilder: (context, index) {
                          final service = _filteredServices[index];
                          final isSelected = _selectedServices.contains(service);

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: CheckboxListTile(
                              value: isSelected,
                              onChanged: (_) => _toggleService(service),
                              title: Text(
                                service.displayName,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(service.description),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(service.category),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          service.category,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (service.language != null) ...[
                                        const SizedBox(width: 8),
                                        Text(
                                          service.language!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Anime':
        return Colors.purple;
      case 'Movies':
        return Colors.blue;
      case 'TV Shows':
        return Colors.green;
      case 'Novels':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}