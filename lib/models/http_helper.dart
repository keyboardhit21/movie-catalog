import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import './movie.dart';

class HttpHelper {

  final String urlKey = 'api_key=173d518fc2bf3776f3f894d3044a8751';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase = 'https://api.themoviedb.org/3/search/movie?api_key=173d518fc2bf3776f3f894d3044a8751&query=';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }

  Future<List> findMovies(String title) async {
    final String query = urlSearchBase +  title;
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }
}