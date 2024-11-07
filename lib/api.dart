import 'package:tmdb_api/tmdb_api.dart';

class ApiService {
  final TMDB _tmdb;
  ApiService()
      : _tmdb = TMDB(ApiKeys(
          'f4dbff6144efdd9165188aa55408ef9a',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGRiZmY2MTQ0ZWZkZDkxNjUxODhhYTU1NDA4ZWY5YSIsIm5iZiI6MTczMDcwOTM1MS41ODc0NDk2LCJzdWIiOiI2NjQ4NzRlYTg1NWJlYTkwZjIxZDQ2OTgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NnOyu7W6s0wJP5gjGr19SPUeyV8bTzkQhPDDf4L2T8w',
        )) {
    setGenres();
  }

  List genres = [];
  List nowPlaying = [];
  List movies = [];
  List popularMovies = [];
  List popularSeries = [];
  List upComing = [];

  void setGenres() async {
    try {
      final result = await _tmdb.v3.genres.getMovieList();
      result['genres'].forEach((element) {
        if (element["id"] >= genres.length) {
          genres.length = element["id"] + 1;
        }
        genres[element["id"]] = element["name"];
      });
    } catch (e) {
      print("Error fetching genres: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getNowPlayingMovies() async {
    try {
      final response = await _tmdb.v3.movies.getNowPlaying(language: "tr");
      final results = List<Map<String, dynamic>>.from(response['results']);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    try {
      final response = await _tmdb.v3.trending.getTrending(mediaType: MediaType.movie, language: "tr");
      final results = List<Map<String, dynamic>>.from(response['results']);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getGenreValue() async {
    try {
      final response = await _tmdb.v3.movies.getPopular(language: "tr");
      final results = List<Map<String, dynamic>>.from(response['results']);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getMovieDetail(int id) async {
    try {
      final response = await _tmdb.v3.movies.getDetails(id, language: "tr");
      final results = Map<String, dynamic>.from(response);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> getCredits(int id) async {
    try {
      final response = await _tmdb.v3.movies.getCredits(id);
      final results = Map<String, dynamic>.from(response);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> getImages(int id) async {
    try {
      final response = await _tmdb.v3.movies.getImages(id);
      final results = Map<String, dynamic>.from(response["results"]);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> getVideos(int id) async {
    try {
      final response = await _tmdb.v3.movies.getVideos(id);
      final results = Map<String, dynamic>.from(response);
      return results;
    } catch (e) {
      print("Error fetching now playing movies: $e");
      return {};
    }
  }
}
