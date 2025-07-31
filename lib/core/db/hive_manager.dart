import 'package:hive/hive.dart';
import '../models/movie_list_response.dart';

class HiveManager {
  static const String bookmarkBoxName = "bookmarks";
  static const String searchResultsBoxName = "search_results";

  static Future<void> init() async {
    Hive.registerAdapter(MovieListResponseAdapter());
    Hive.registerAdapter(ResultsAdapter());

    await Hive.openBox<Results>(bookmarkBoxName);
    await Hive.openBox<MovieListResponse>(searchResultsBoxName);
  }

  static Box<Results> get bookmarkBox => Hive.box<Results>(bookmarkBoxName);
  static Box<MovieListResponse> get searchResultsBox =>
      Hive.box<MovieListResponse>(searchResultsBoxName);
}
