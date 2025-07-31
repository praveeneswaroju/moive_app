import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/stores/bookmark_store.dart';
import 'stores/movie_store.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MovieStore _movieStore = MovieStore();
  final BookmarkStore _bookmarkStore = BookmarkStore();

  @override
  void initState() {
    super.initState();
    _movieStore.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF23272E),
      ),
      home: HomePage(store: _movieStore, bmStore: _bookmarkStore),
    );
  }
}
