import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
            backgroundImage: NetworkImage(
              Text(data[index]["poster_url"]),
            ),
          ),
            title: data[index]["title"]
        );
        },
      ),
    );
  }
}

