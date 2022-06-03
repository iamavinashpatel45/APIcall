import 'package:apicall/imageviewer.dart';
import 'package:apicall/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myapp(),
    );
  }
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  List? mapdata;
  int? page;
  int? perpageitem;
  //bool image = false;

  jasondata(String p) async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=' + p));
    setState(() {
      var map = json.decode(response.body);
      mapdata = mapdata! + map['data'];
    });
  }

  jasonpage() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    setState(() {
      var map = json.decode(response.body);
      page = map['total_pages'];
      perpageitem=map['per_page'];
      mapdata = map['data'];
    });
  }

  call() async {
    await jasonpage();
    for (int i = 2; i <= page!; i++) {
      await jasondata(i.toString());
    }
  }

  @override
  void initState() {
    call();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('API CAll'),
      ),
      body: mapdata == null //&& perpageitem!*page! ==mapdata?.length
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mapdata?.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => person(
                                      list: [mapdata![index]],
                                    ))),
                        child: ListTile(
                          leading: InkWell(
                            onTap: () => {
                              showDialog(
                                  context: context,
                                  builder: (context)=>dialogview(ima: mapdata![index]['avatar']))
                            },
                            child: Hero(
                              tag: Key(mapdata![index]['avatar']),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child:
                                      Image.network(mapdata![index]['avatar'])),
                            ),
                          ),
                          title: Text(mapdata![index]['first_name']),
                          subtitle: Text(mapdata![index]['email']),
                          trailing: Text(mapdata![index]['id'].toString()),
                        ),
                      ),
                    ),
                  )),
    );
  }
}
