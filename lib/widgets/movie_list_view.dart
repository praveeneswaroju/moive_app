import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../core/models/movie_list_response.dart';
import '../stores/bookmark_store.dart';
import 'movie_card.dart';

class MovieListView extends StatelessWidget {
  final String title;
  final List<Results> movies;
  final BookmarkStore bmStore;

  const MovieListView({
    super.key,
    required this.title,
    required this.movies,
    required this.bmStore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        // for trending movies, use CarouselSlider and for others use ListView
        title == 'Trending Movies'
            ? SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: movies.length,
                options: CarouselOptions(
                  height: 270,
                  autoPlay: true,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                ),
                itemBuilder:
                    (context, index, pageViewIndex) =>
                        MovieCard(movie: movies[index], bookmarkStore: bmStore),
              ),
            )
            : SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder:
                    (context, index) =>
                        MovieCard(movie: movies[index], bookmarkStore: bmStore),
              ),
            ),
      ],
    );
  }
}
