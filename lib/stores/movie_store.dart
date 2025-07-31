import 'package:mobx/mobx.dart';
import '../core/api/movie_service.dart';
import '../core/models/movie_list_response.dart';

class MovieStore with Store {
  final MovieService _movieService = MovieService();

  final Observable<ObservableFuture<MovieListResponse?>?> trendingMovies =
      Observable(null);
  final Observable<ObservableFuture<MovieListResponse?>?> nowPlayingMovies =
      Observable(null);

  bool isLoading = false;

  ///[loadMovies]used to fetch the trending and now playing movies from the API.
  @action
  Future<void> loadMovies() async {
    isLoading = true;
    try {
      final trending = await _movieService.fetchTrendingMovies();
      final nowPlaying = await _movieService.fetchNowPlayingMovies();

      runInAction(
        () => trendingMovies.value = ObservableFuture(Future.value(trending)),
      );
      runInAction(
        () =>
            nowPlayingMovies.value = ObservableFuture(Future.value(nowPlaying)),
      );
    } finally {
      isLoading = false;
    }
  }

  /// [clearData] clears the data in the store.
  void clearData() {
    runInAction(() {
      trendingMovies.value = null;
      nowPlayingMovies.value = null;
    });
    isLoading = false;
  }
}
