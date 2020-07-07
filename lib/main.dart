import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:gti_sesa_saude/models/unidade.model.dar';


void main() {
  runApp(
    MaterialApp(
      home: new HomePage(),
    ),
  );
}

//Scaffold(
//backgroundColor: Colors.blueGrey[500],
//appBar: AppBar(
//title: Text('Lista de Livros'),
//backgroundColor: Colors.blueGrey[900],
//),
//),

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{
  var _textController = new TextEditingController();
  final String url = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies';
  List data;


  Future<String> getJsonData() async{
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    print(response);
    setState(() {
      data = json.decode(response.body);

    });
  }

  @override
  void initState(){
    super.initState();
    this.getJsonData();

  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lista de Livros'),
        //backgroundColor: Colors.blueGrey[900],
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
        return ListTile(

          leading: CircleAvatar(
            backgroundImage: NetworkImage( data[index]['poster_url']),
            //child: Image.asset( data[index]['poster_url'])  ,
          ),
          title: new Text( data[index]['title'] ),
         trailing: Icon(Icons.keyboard_arrow_right),
         onTap: (){
            var route = new MaterialPageRoute(
                builder: (BuildContext context) => new NextPage(urls: url + "/"+ data[index]['id'].toString())

            );
          Navigator.of(context).push(route);
            },

         // subtitle: new Text( data[index]['vote_average']),
          );

        //);
        },
      ),
    );
  }
}

//
//
// NEXT PAGE
//
//
//

class NextPage extends StatefulWidget {
  final String urls;
  NextPage({Key key, this.urls}) : super (key:key);

  @override
  _NextPageState createState() => _NextPageState();
}



class _NextPageState extends State<NextPage> {

 // List data;
  Future<Infos> infos;

  Future<Infos> getFutureData() async{
    print(widget.urls.toString());
    http.Response response = await http.get(Uri.encodeFull(widget.urls),headers: {"Accept": "application/json"});
    // if(response.statusCode == 200){
    print(response);
    //return
    await Future.delayed(Duration(seconds: 3));
    String content = response.body;

    return Infos.fromJson(json.decode(content));

  }


  Future getData() async{
    //infos = await getFutureData();
  //  getFutureData().then((Infos _info){
    //  setState(() {
      //  infos = _info;
      //});
    }



     // setState(() {
     //   infos = await Infos.fromJson(json.decode((response.body))));
      //data = json.decode(response.body);

     // });
  //  } else {
   //   throw Exception("NO response from server");
   // }



  @override
  void initState(){
    super.initState();
    infos = getFutureData();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Next Page"),
      ),
      body: Center(
        child: FutureBuilder<Infos>(
            future: infos,
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return Container(
                  width: 100,
                  height: 100,
                  color: snapshot.hasData ? Colors.green : Colors.red,
                );
            }
          // child: Text(data['id'].toString()),
        ),

      )


    );
  }
}

class Infos{
  final bool adult;
  final String backdrop_url;
  final String belongs_to_collection;
  final int budget;
  final List genres;
  final String homepage;
  final int id;
  final int imdb_id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_url;
  final List production_companies;
  final List production_countries;
  final String release_date;
  final int revenue;
  final int runtime;
  final List spoken_languages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;

  Infos({this.adult, this.backdrop_url, this.belongs_to_collection, this.budget,
    this.genres, this.homepage, this.id, this.imdb_id, this.original_language, this.original_title,
    this.overview, this.popularity,this.poster_url, this.production_companies, this.production_countries,
    this.release_date, this.revenue, this.runtime, this.spoken_languages, this.status, this.tagline,
    this.title, this.video,this.vote_average, this.vote_count});

  factory Infos.fromJson(Map<String, dynamic> json){
    return Infos(
      adult : json['adult'],
      backdrop_url : json['backdrop_url'],
      belongs_to_collection : json['belongs_to_collection'],
      budget : json['budget'],
      genres : json['genres'],
      homepage : json['homepage'],
      id : json['id'],
      imdb_id : json['imdb_id'],
      original_language : json['original_language'],
      original_title : json['original_tile'],
      overview : json['overview'],
      popularity: json['popularity'],
      poster_url : json['poster_url'],
      production_companies : json['production_companies'],
      production_countries : json['production_countries'],
      release_date : json['release_date'],
      revenue : json['revenue'],
      runtime : json['runtime'],
      spoken_languages : json['spoken_languages '],
      status : json['status'],
      tagline : json['tagline'],
      title : json['title'],
      video : json['video'],
      vote_average : json['vote_average'],
      vote_count : json['vote_count'],
    );
  }

}