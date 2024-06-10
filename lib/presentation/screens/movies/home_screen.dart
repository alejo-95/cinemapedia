import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustombottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topReatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoandingprovider);

    if (initialLoading) return const FullScreenLoader();

    
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topReatedMoviesProvider);

    final slideShowMovies = ref.watch(moviesSlideshowProvider);   

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: slideShowMovies),
            MovieHorizontallistview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 20',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
              //loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontallistview(
              movies: upComingMovies,
              title: 'Proximamente',
              subTitle: 'Este mes',
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
              //loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontallistview(
              movies: popularMovies,
              title: 'Populares',
              //subTitle: '',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
              //loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontallistview(
              movies: topRatedMovies,
              title: 'Las mejores',
              subTitle: 'Baúl de joyas',
              loadNextPage: () {
                ref.read(topReatedMoviesProvider.notifier).loadNextPage();
              },
              //loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
