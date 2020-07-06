import 'package:flutter/material.dart';

class Cardair extends StatefulWidget {
  Cardair(List adata);

  // final List<dynamic> dataku;
  // Cardair(this.dataku, {Key key});
  _CardairState createState() => _CardairState();
}

class _CardairState extends State<Cardair> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 12.0, bottom: 0.0, right: 8.0, left: 8.0),
              width: double.maxFinite,
              child: Stack(
                children: <Widget>[
                  Icon(Icons.graphic_eq),
                  Align(
                    alignment: Alignment(-0.35, -0.75),
                    child: Text(
                      "asdfasdfasdf",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
