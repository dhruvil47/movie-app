import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:movieapp/search.dart';

import '../config.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    return new MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movies;
  
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
      
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return new Scaffold(
      backgroundColor: Colors.white,
      //drawer: Drawer(),
      // appBar: new AppBar(
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.search), onPressed: (){
      //       showSearch(context: context, delegate: Search(movies));
      //     })
      //   ],
      //   elevation: 0.3,
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   title: new Text(
      //     'Movies',
      //     style: new TextStyle(
      //         color: Colors.black,
              
      //         fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: 
      
      new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(icon: Icon(Icons.search,size: 35,), onPressed: (){
              showSearch(context: context, delegate: Search(movies));
          }),
            ),
            //new MovieTitle(mainColor),
            new Expanded(
              child: new ListView.builder(
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return new Container(
                       margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            //offset: Offset(7, 7),
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: new MovieCell(movies, i),
                      padding: const EdgeInsets.all(0.0),
                      
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var apiKey = getApiKey();
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}';  
  var response = await http.get(url);
  return json.decode(response.body);
}

// class MovieTitle extends StatelessWidget {
//   final Color mainColor;

//   MovieTitle(this.mainColor);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
        
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//         child: new Text(
//           'Top Rated',
//           style: new TextStyle(
//               fontSize: 40.0,
//               color: mainColor,
//               fontWeight: FontWeight.bold,
//               ),
//           textAlign: TextAlign.left,
//         ),
//       ),
//     );
//   }
// }

class MovieCell extends StatelessWidget {

  
  final movies;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.i);
  
  
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
//                                child: new Image.network(image_url+movies[i]['poster_path'],width: 100.0,height: 100.0),
                child: new Container(
                  width: 100.0,
                  height: 150.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: new DecorationImage(
                      image: new NetworkImage(
                          image_url + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Expanded(
                child: new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Column(
                children: [
                  new Text(
                    movies[i]['title'],
                    style: new TextStyle(
                        fontSize: 20.0,
                        
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  new Padding(padding: const EdgeInsets.all(4.0)),
                  new Text(
                    movies[i]['overview'],
                    maxLines: 3,
                    style: new TextStyle(
                        color: const Color(0xff8785A4),),
                  ),
                  new Padding(padding: const EdgeInsets.all(4.0)),
                  Row(
                    children: [
                      new Text(
                        movies[i]['vote_average'].toString(),
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ) 
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            
                            //offset: Offset(7, 7),
                            blurRadius: 3
                          )
                        ]
                        ),
                        child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: movies[i]['vote_average'].toDouble(),
                        size: 30.0,
                        isReadOnly:true,
                        //fullRatedIconData: Icons.blur_off,
                        //halfRatedIconData: Icons.blur_on,
                        color: Colors.orange,
                        borderColor: Colors.orange,
                        spacing:0.0
                        ),
                      )
                    ],
                  )

                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )),
          ],
        ),
        // new Container(
        //   width: 300.0,
        //   height: 0.5,
        //   // color: const Color(0xD2D2E1ff),
        //   margin: const EdgeInsets.all(16.0),
        // )
      ],
    );
  }
}


