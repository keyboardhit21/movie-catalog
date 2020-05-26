import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'widgets/movie_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  const Home({Key key,}) : super(key: key);
}

class _HomeState extends State<Home> {

  ValueNotifier<String> searchKeyword = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.green,
          ),
          onSubmitted: (text) {
            this.searchKeyword.value = text;
          },
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: this.searchKeyword,
          builder: (BuildContext context, String value, Widget child) {
            return MovieList(searchWord: value);
          },
        )
      )
    );
  }
}
