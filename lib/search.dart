import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Search extends SearchDelegate{
  final movie;
  Search(this.movie);


  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){
          query = '';
        })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    final suggestionList 
      = 
        query.isEmpty
        ? movie
        : movie
            .where((element) =>
                element['title'].toString().toLowerCase().startsWith(query)).toList()
            ;

         return ListView.builder(
                  itemCount: suggestionList == null ? 0 : suggestionList.length,
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
                      child:  MovieCell(suggestionList, i),
                      padding: const EdgeInsets.all(0.0),
                      
                    );
                  });
  }

}

class MovieCell extends StatelessWidget {

  
  final suggestionList;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.suggestionList, this.i);
  
  
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
                          image_url + suggestionList[i]['poster_path']),
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
                    suggestionList[i]['title'],
                    style: new TextStyle(
                        fontSize: 20.0,
                        
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  new Padding(padding: const EdgeInsets.all(4.0)),
                  new Text(
                    suggestionList[i]['overview'],
                    maxLines: 3,
                    style: new TextStyle(
                        color: const Color(0xff8785A4),),
                  ),
                  new Padding(padding: const EdgeInsets.all(4.0)),
                  Row(
                    children: [
                      new Text(
                        suggestionList[i]['vote_average'].toString(),
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
                        rating: suggestionList[i]['vote_average'].toDouble(),
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