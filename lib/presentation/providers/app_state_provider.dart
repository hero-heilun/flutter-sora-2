import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/search_result.dart';
import '../../services/service_manager.dart';

// Service management state
final servicesProvider = StateNotifierProvider<ServicesNotifier, List<Service>>((ref) {
  return ServicesNotifier();
});

class ServicesNotifier extends StateNotifier<List<Service>> {
  ServicesNotifier() : super([]) {
    _loadServices();
  }

  Future<void> _loadServices() async {
    // Wait for ServiceManager to initialize if not already done
    if (ServiceManager.instance.services.isEmpty) {
      await ServiceManager.instance.initialize();
    }
    state = ServiceManager.instance.services;
  }

  Future<void> addService(String url) async {
    await ServiceManager.instance.addService(url);
    state = ServiceManager.instance.services;
  }

  Future<void> removeService(String serviceId) async {
    await ServiceManager.instance.removeService(serviceId);
    state = ServiceManager.instance.services;
  }

  Future<void> setActiveService(String serviceId) async {
    await ServiceManager.instance.setActiveService(serviceId);
    state = ServiceManager.instance.services;
  }

  Service? get activeService => ServiceManager.instance.activeService;
}

// Search state
final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

class SearchState {
  final List<SearchItem> results;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.results = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  SearchState copyWith({
    List<SearchItem>? results,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      state = const SearchState();
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final results = await ServiceManager.instance.search(keyword);
      state = state.copyWith(
        results: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Search failed: $e',
      );
    }
  }

  void clearSearch() {
    state = const SearchState();
  }
}

// Details state
final detailsProvider = StateNotifierProvider.family<DetailsNotifier, DetailsState, String>((ref, url) {
  return DetailsNotifier(url);
});

class DetailsState {
  final List<MediaItem> details;
  final List<EpisodeLink> episodes;
  final bool isLoadingDetails;
  final bool isLoadingEpisodes;
  final String? errorMessage;

  const DetailsState({
    this.details = const [],
    this.episodes = const [],
    this.isLoadingDetails = false,
    this.isLoadingEpisodes = false,
    this.errorMessage,
  });

  DetailsState copyWith({
    List<MediaItem>? details,
    List<EpisodeLink>? episodes,
    bool? isLoadingDetails,
    bool? isLoadingEpisodes,
    String? errorMessage,
  }) {
    return DetailsState(
      details: details ?? this.details,
      episodes: episodes ?? this.episodes,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      isLoadingEpisodes: isLoadingEpisodes ?? this.isLoadingEpisodes,
      errorMessage: errorMessage,
    );
  }
}

class DetailsNotifier extends StateNotifier<DetailsState> {
  final String url;

  DetailsNotifier(this.url) : super(const DetailsState()) {
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadDetails(),
      _loadEpisodes(),
    ]);
  }

  Future<void> _loadDetails() async {
    state = state.copyWith(isLoadingDetails: true, errorMessage: null);

    try {
      final details = await ServiceManager.instance.getDetails(url);
      state = state.copyWith(
        details: details,
        isLoadingDetails: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingDetails: false,
        errorMessage: 'Failed to load details: $e',
      );
    }
  }

  Future<void> _loadEpisodes() async {
    state = state.copyWith(isLoadingEpisodes: true);

    try {
      final episodes = await ServiceManager.instance.getEpisodes(url);
      state = state.copyWith(
        episodes: episodes,
        isLoadingEpisodes: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingEpisodes: false,
        errorMessage: 'Failed to load episodes: $e',
      );
    }
  }

  Future<StreamData?> getStreamData(String episodeUrl) async {
    return await ServiceManager.instance.getStreamUrl(episodeUrl);
  }
}