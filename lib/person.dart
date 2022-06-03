import 'package:flutter/material.dart';

import 'imageviewer.dart';
import 'main.dart';

class person extends StatelessWidget {
  //const person({Key? key}) : super(key: key);

  final List list;

  const person({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: kToolbarHeight * 1.5,
                color: Colors.blue,
              ),
              Positioned(
                top: (kToolbarHeight * 1.5) / 2,
                left: 10,
                child: InkWell(
                  onTap: () => Navigator.pop(
                      context, MaterialPageRoute(builder: (context) => app())),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Positioned(
                  child: Center(
                    child: InkWell(
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context)=>dialogview(ima:list[0]['avatar']))
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Hero(
                          tag: Key(list[0]['avatar']),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.network(
                                list[0]['avatar'],
                                height: 100,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              list[0]['first_name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Text(
            list[0]['email'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
