import 'package:flutter/material.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/components/horizontal_card.dart';
import 'package:movie_app/components/title_head.dart';
import 'package:movie_app/components/vertical_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.width = 0, this.height = 0});

  final double width;
  final double height;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> nowPlayingMovies = [];
  List<Map<String, dynamic>> popularMovies = [];

  //ApiService().getNowPlayingMovies();
  @override
  void initState() {
    super.initState();
    getPageData();
  }

  Future<void> getPageData() async {
    final movies = await apiService.getNowPlayingMovies();
    final pMovies = await apiService.getPopularMovies();
    setState(() {
      nowPlayingMovies = movies;
      popularMovies = pMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const TitleHead(
            title: "Gösterime Girenler",
            buttonText: "Tümünü Göster",
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: nowPlayingMovies.map((movie) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                  ), // Kartlar arasında boşluk
                  child: VerticalCard(
                    image:
                        "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                    title: movie['title'],
                    vote: movie['vote_average'],
                    // Diğer film bilgileri de eklenebilir
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24),
          TitleHead(
            title: "Popüler Filmler",
            buttonText: "Tümünü Göster",
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              children: popularMovies.map((movie) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                  ), // Kartlar arasında boşluk
                  child: HorizontalCard(
                    id: movie["id"],
                    image:
                        "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                    title: movie['title'],
                    vote: movie['vote_average'],
                    genreList: movie['genre_ids'],
                    // Diğer film bilgileri de eklenebilir
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
