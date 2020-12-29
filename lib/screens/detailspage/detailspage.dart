import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  var moviesID;
  DetailsPage(this.moviesID);
  @override
  _DetailsPageState createState() => _DetailsPageState(this.moviesID);
}

class _DetailsPageState extends State<DetailsPage> {
  var detailsPageUrl = "https://yts.mx/api/v2/movie_details.json?movie_id=";
  var newData;
  final int moviesID;

  _DetailsPageState(this.moviesID);

  _jsonMoviesDetails() async {
    var response = await http.get(detailsPageUrl + moviesID.toString());
    print(response);
    newData = jsonDecode(response.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moviesID.toString()),
        actions: [
          _refreshDetailPage(),
        ],
      ),
      body: newData != null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(29.0),
                        ),
                        child: Image.network(
                            newData["data"]["movie"]["small_cover_image"]),
                      ),
                      Text(newData["data"]["movie"]["title"]),
                      Text(newData["data"]["movie"]["year"]),
                      Text(newData["data"]["movie"]["rating"]),
                      Text(newData["data"]["movie"]["description_full"]),
                      Text(newData["data"]["movie"]["runtime"]),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(newData["data"]["movie"]["quality"]),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Text("Movies Not Found"),
            ),
    );
  }

  Widget _refreshDetailPage() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          _jsonMoviesDetails();
        });
  }
}
