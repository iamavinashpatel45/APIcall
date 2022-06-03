import 'package:flutter/material.dart';

class dialogview extends StatefulWidget {
  final String ima;

  const dialogview({Key? key, required this.ima}) : super(key: key);

  @override
  State<dialogview> createState() => _dialogviewState();
}

class _dialogviewState extends State<dialogview> {
  bool image = true;

  @override
  void initState() {
    getData(widget.ima);
    super.initState();
  }

  String? i;

  getData(String image) {
    i = image;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: InkWell(
        onTap: () {
          //print(image.toString());
          setState(() {
            if (image) {
              image = false;
            } else {
              image = true;
            }
          });
        },
        child: image
            ? Image.network(
                i!,
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              )
            : Image.network(
                i!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
    ;
  }
}
