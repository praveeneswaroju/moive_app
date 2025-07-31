import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/bookmark_store.dart';
import '../stores/movie_store.dart';
import '../widgets/movie_list_view.dart';
import 'search_page.dart';
import 'bookmarks_page.dart';

class HomePage extends StatelessWidget {
  final MovieStore store;
  final BookmarkStore bmStore;

  const HomePage({super.key, required this.store, required this.bmStore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/flutflix.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
      ),
      body: Observer(
        builder: (_) {
          final trendingMoviesValue = store.trendingMovies.value;
          final nowPlayingMoviesValue = store.nowPlayingMovies.value;
          final trendingMovies = trendingMoviesValue?.value?.results ?? [];
          final nowPlayingMovies = nowPlayingMoviesValue?.value?.results ?? [];

          if (store.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                MovieListView(
                  title: "Trending Movies",
                  movies: trendingMovies,
                  bmStore: bmStore,
                ),
                const SizedBox(height: 32),
                MovieListView(
                  title: "Now Playing",
                  movies: nowPlayingMovies,
                  bmStore: bmStore,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchPage(bookmarkStore: bmStore),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookmarksPage(bookmarkStore: bmStore),
              ),
            );
          }
        },
      ),
    );
  }
}
