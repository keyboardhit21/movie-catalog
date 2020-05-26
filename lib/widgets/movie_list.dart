import 'package:flutter/material.dart';
import '../models/http_helper.dart';
import 'package:intl/intl.dart';
import '../pages/detail.dart';


class MovieList extends StatefulWidget {

  final String searchWord;

  MovieList({Key key, @required this.searchWord}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();

}

class _MovieListState extends State<MovieList> {

  int moviesCount;
  List result;
  List movies;
  HttpHelper helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';


  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  void didUpdateWidget(MovieList oldWidget) {
    search(widget.searchWord);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    NetworkImage image;

    return FutureBuilder(
      future: (widget.searchWord == '') ? initialize() : search(widget.searchWord),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        movies = snapshot.data;
        print(movies);

        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder (
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int position) {
            if (movies[position].posterPath != null) {
              image = NetworkImage(
                iconBase + movies[position].posterPath,
              );
            }
            else { 
              image = NetworkImage(defaultImage);
            }

            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(movies[position].title),
                subtitle: Text('Released: ' + DateFormat('yMMMM').format(DateTime.parse(movies[position].releaseDate)) + ' - Vote: ' + movies[position].voteAverage.toString()),
                leading: CircleAvatar(
                  backgroundImage: image,

                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieDetail(movies[position])),
                  );
                },
              ),
            );
          }
        );
      },
    );
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    return movies;
  }

  Future search(String text) async {
    movies = List();
    movies = await helper.findMovies(text);
    return movies;
  }
}