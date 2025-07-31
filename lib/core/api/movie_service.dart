import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import '../db/hive_manager.dart';
import '../models/movie_list_response.dart';
import 'api_client.dart';
import '../utils/constants.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient();

  final Box _trendingBox = Hive.box('trending_movies');
  final Box _nowPlayingBox = Hive.box('now_playing_movies');
  final Box<MovieListResponse> _searchResultsBox = HiveManager.searchResultsBox;

  /// Fetches trending movies from the API or cache.
  Future<MovieListResponse?> fetchTrendingMovies() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    final isOffline =
        connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none);

    if (isOffline) {
      final cachedJson = _trendingBox.get('data');
      if (cachedJson != null) {
        return MovieListResponse.fromJson(
          Map<String, dynamic>.from(cachedJson),
        );
      } else {
        return null;
      }
    }

    // 🌐 ONLINE MODE
    final json = await _apiClient.get(Constants.trendingEndpoint);
    _trendingBox.put('data', json);
    return MovieListResponse.fromJson(json);
  }

  /// Fetches now playing movies from the API or cache.
  Future<MovieListResponse?> fetchNowPlayingMovies() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    final isOffline =
        connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none);

    if (isOffline) {
      final cachedJson = _nowPlayingBox.get('data');
      if (cachedJson != null) {
        return MovieListResponse.fromJson(
          Map<String, dynamic>.from(cachedJson),
        );
      } else {
        return null;
      }
    }

    final json = await _apiClient.get(Constants.nowPlayingEndpoint);
    _nowPlayingBox.put('data', json);
    return MovieListResponse.fromJson(json);
  }

  /// Searches for movies by query.
  Future<MovieListResponse?> searchMovies(String query) async {
    final key = 'query_${query.toLowerCase()}';

    final connectivityResults = await Connectivity().checkConnectivity();
    final isOffline =
        connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none);

    if (isOffline) {
      // Offline: Return cached result if available
      final cached = _searchResultsBox.get(key);
      return cached;
    } else {
      // Online: Fetch from API
      final json = await _apiClient.get(
        Constants.searchMovieEndpoint,
        params: {'query': query},
      );
      final response = MovieListResponse.fromJson(json);

      // Save to Hive for offline usage
      await _searchResultsBox.put(key, response);

      return response;
    }
  }
}
