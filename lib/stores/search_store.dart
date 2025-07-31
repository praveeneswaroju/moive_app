import 'package:mobx/mobx.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/models/movie_list_response.dart';
import '../core/api/movie_service.dart';
import '../core/db/hive_manager.dart';

class SearchStore with Store {
  final MovieService _movieService = MovieService();
  final _cacheBox = HiveManager.searchResultsBox;

  Observable<ObservableFuture<MovieListResponse?>?> searchResults = Observable(
    null,
  );

  @observable
  bool isSearching = false;

  static const _cacheKeyPrefix = 'query_';

  /// [searchMovies] fetches from API if online, else loads from Hive.
  @action
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;
    isSearching = true;

    final key = _cacheKeyPrefix + query.toLowerCase();
    final connectivityResults = await Connectivity().checkConnectivity();
    final isOffline =
        connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none);

    try {
      // If offline, load from cache
      if (isOffline) {
        final cached = _cacheBox.get(key);
        if (cached != null) {
          runInAction(() {
            searchResults.value = ObservableFuture(Future.value(cached));
          });
        }
      } else {
        // Online – fetch from API
        final response = await _movieService.searchMovies(query);
        if (response != null) {
          await _cacheBox.put(key, response); // 💾 Store model directly
        }
        runInAction(() {
          searchResults.value = ObservableFuture(Future.value(response));
        });
      }
    } finally {
      isSearching = false;
    }
  }

  /// [clearResults] clears the search results and resets the searching state.
  void clearResults() {
    runInAction(() => searchResults.value = null);
    isSearching = false;
  }
}
