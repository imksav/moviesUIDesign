import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieUIDesign/screens/detailspage/detailspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double height;
  double width;
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies Grid View"),
        actions: [
          _refreshButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: _myList(),
        ),
      ),
    );
  }

  Widget _myList() {
    return data != null
        ? Container(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: data["data"]["movie_count"] < data["data"]["limit"]
                  ? data["data"]["movie_count"]
                  : data["data"]["limit"],
              itemBuilder: (context, index) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(data["data"]["movies"][index]["id"]),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(29.0)),
                      child: Image.network(
                        data["data"]["movies"][index]["large_cover_image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: Text("No result found"),
          );
  }

  Widget _refreshButton() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          _jsonData();
        });
  }

  _jsonData() async {
    String url = "https://yts.mx/api/v2/list_movies.json?limit=20";
    var response = await http.get(url);
    data = jsonDecode(response.body);
    print(data["status_message"]);
    setState(() {});
    // _responseDecoder(response);
  }
}
