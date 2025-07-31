import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import '../core/db/hive_manager.dart';
import '../core/models/movie_list_response.dart';

class BookmarkStore with Store {
  final Box<Results> _box = HiveManager.bookmarkBox;

  Observable<List<Results>> bookmarks = Observable<List<Results>>([]);

  /// [loadBookmarks] loads the bookmarks from the Hive box.
  @action
  void loadBookmarks() {
    runInAction(() => bookmarks.value = _box.values.toList());
  }

  /// [isBookmarked] checks if a movie is bookmarked.
  @action
  void toggleBookmark(Results movie) {
    if (_box.containsKey(movie.id)) {
      _box.delete(movie.id);
    } else {
      _box.put(movie.id, movie);
    }
    loadBookmarks();
  }
}
