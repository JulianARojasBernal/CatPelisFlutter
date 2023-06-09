import 'package:flutter_movies_app/domain/entities/movie.dart';
import 'package:flutter_movies_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final upComingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallback  = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>>{
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  MoviesNotifier({
    required this.fetchMoreMovies
  })
  : super([]);

  Future<void> loadNextPage() async {
    if(isLoading)return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await newMethod();
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 200));
    isLoading = false;
  }

  Future<List<Movie>> newMethod() async => await fetchMoreMovies(page: currentPage);
}