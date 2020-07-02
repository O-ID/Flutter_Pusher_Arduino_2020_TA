import 'package:flutter/material.dart';

class Listcard extends StatefulWidget {
  final List<dynamic> dataku;
  Listcard(this.dataku, {Key key});
  _ListcardState createState() => _ListcardState();
}

class _ListcardState extends State<Listcard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3),
        //isi panjang card itemcount
        itemCount: widget.dataku[0]['S5'] == null ? 4 : 6,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(8.0),
                    width: double.maxFinite,
                    child: Text(
                      "DHT22 Ke-${index.toString()}",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        verticalDirection: VerticalDirection.up,
                        children: <Widget>[
                          Text(
                            "${widget.dataku[0]['S' + index.toString()].toString()}°C",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: Text(
                              "Suhu",
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      )),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          verticalDirection: VerticalDirection.up,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Lembab",
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: Text(
                                    "${widget.dataku[0]['L' + index.toString()].toString()}%",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Mode : ${widget.dataku[0]['m' + index.toString()].toString()}"),
                )
                // RaisedButton(
                //   onPressed: () => _prinn(widget.dataku[index]),
                //   child: Text(index.toString()),
                // )
                // FloatingActionButton(onPressed: () => _prinn(widget.dataku[i])),
              ],
            ),
          );
        });
  }
}
