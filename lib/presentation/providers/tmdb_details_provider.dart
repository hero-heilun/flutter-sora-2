import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/tmdb_models.dart';
import '../../services/tmdb_service.dart';

// TMDB Details state
class TMDBDetailsState {
  final bool isLoading;
  final String? errorMessage;
  final TMDBMovieDetail? movieDetail;
  final TMDBTVShowDetail? tvShowDetail;
  final List<TMDBSeasonDetail> seasonDetails;
  final int? selectedSeasonNumber;

  const TMDBDetailsState({
    this.isLoading = false,
    this.errorMessage,
    this.movieDetail,
    this.tvShowDetail,
    this.seasonDetails = const [],
    this.selectedSeasonNumber,
  });

  TMDBDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    TMDBMovieDetail? movieDetail,
    TMDBTVShowDetail? tvShowDetail,
    List<TMDBSeasonDetail>? seasonDetails,
    int? selectedSeasonNumber,
  }) {
    return TMDBDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      movieDetail: movieDetail ?? this.movieDetail,
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      seasonDetails: seasonDetails ?? this.seasonDetails,
      selectedSeasonNumber: selectedSeasonNumber ?? this.selectedSeasonNumber,
    );
  }
}

class TMDBDetailsNotifier extends StateNotifier<TMDBDetailsState> {
  TMDBDetailsNotifier() : super(const TMDBDetailsState());

  Future<void> loadMovieDetails(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final movieDetail = await TMDBService.instance.getMovieDetails(id);
      state = state.copyWith(
        isLoading: false,
        movieDetail: movieDetail,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load movie details: $e',
      );
    }
  }

  Future<void> loadTVShowDetails(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final tvShowDetail = await TMDBService.instance.getTVShowDetails(id);
      state = state.copyWith(
        isLoading: false,
        tvShowDetail: tvShowDetail,
        selectedSeasonNumber: 1, // Default to season 1
      );
      
      // Load all seasons basic info and first season details
      if (tvShowDetail.numberOfSeasons != null && tvShowDetail.numberOfSeasons! > 0) {
        // Load basic info for all seasons first (this gives us season names and posters)
        for (int seasonNum = 1; seasonNum <= tvShowDetail.numberOfSeasons!; seasonNum++) {
          try {
            final seasonDetail = await TMDBService.instance.getSeasonDetails(id, seasonNum);
            final updatedSeasonDetails = [...state.seasonDetails];
            final existingIndex = updatedSeasonDetails.indexWhere(
              (season) => season.seasonNumber == seasonNum,
            );
            
            if (existingIndex != -1) {
              updatedSeasonDetails[existingIndex] = seasonDetail;
            } else {
              updatedSeasonDetails.add(seasonDetail);
            }
            
            state = state.copyWith(seasonDetails: updatedSeasonDetails);
          } catch (e) {
            // Continue loading other seasons even if one fails
            print('Failed to load season $seasonNum: $e');
          }
        }
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load TV show details: $e',
      );
    }
  }

  Future<void> loadSeasonDetails(int tvShowId, int seasonNumber) async {
    try {
      final seasonDetail = await TMDBService.instance.getSeasonDetails(tvShowId, seasonNumber);
      
      // Update or add season detail
      final updatedSeasonDetails = [...state.seasonDetails];
      final existingIndex = updatedSeasonDetails.indexWhere(
        (season) => season.seasonNumber == seasonNumber,
      );
      
      if (existingIndex != -1) {
        updatedSeasonDetails[existingIndex] = seasonDetail;
      } else {
        updatedSeasonDetails.add(seasonDetail);
      }
      
      state = state.copyWith(
        seasonDetails: updatedSeasonDetails,
        selectedSeasonNumber: seasonNumber,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to load season details: $e',
      );
    }
  }

  void selectSeason(int tvShowId, int seasonNumber) {
    state = state.copyWith(selectedSeasonNumber: seasonNumber);
    
    // Load season details if not already loaded
    final hasSeasonDetails = state.seasonDetails.any(
      (season) => season.seasonNumber == seasonNumber,
    );
    
    if (!hasSeasonDetails) {
      loadSeasonDetails(tvShowId, seasonNumber);
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const TMDBDetailsState();
  }
}

// Provider for TMDB details
final tmdbDetailsProvider = StateNotifierProvider<TMDBDetailsNotifier, TMDBDetailsState>((ref) {
  return TMDBDetailsNotifier();
});