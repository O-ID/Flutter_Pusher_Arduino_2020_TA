import 'package:flutter/material.dart';

class Listcard extends StatefulWidget {
  final List<dynamic> dataku;
  Listcard(this.dataku, {Key key});
  _ListcardState createState() => _ListcardState();
}

class _ListcardState extends State<Listcard> {
  bool swiit = false;
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
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
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
                          "DHT22 Ke-${index.toString()}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(1.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment(-0.80, 0.00),
                            child: Text(
                              "${widget.dataku[0]['S' + index.toString()].toString()}°C",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.85, 0.00),
                            child: Text(
                              "Suhu",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 17.0),
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
                      padding: const EdgeInsets.all(1.0),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment(-0.80, 0.00),
                          child: Text(
                            "Lembab",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.85, 0.00),
                          child: Text(
                            "${widget.dataku[0]['L' + index.toString()].toString()}%",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ])),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 0.0, top: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            widget.dataku[0]['m' + index.toString()] == true
                                ? "Manual"
                                : "Otomatis",
                            style: TextStyle(fontSize: 17.00),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Switch(
                                value: widget.dataku[0]['m' + index.toString()],
                                onChanged: (value) {
                                  setState(() {
                                    widget.dataku[0]['m' + index.toString()] =
                                        value;
                                  });
                                }),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
