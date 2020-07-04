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
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(8.0),
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
                    )),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.dataku[0]['m' + index.toString()] == true
                            ? "Manual"
                            : "Otomatis",
                        style: TextStyle(fontSize: 17.00),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                            value: widget.dataku[0]['m' + index.toString()],
                            onChanged: (value) {
                              setState(() {
                                widget.dataku[0]['m' + index.toString()] =
                                    value;
                              });
                            }))
                  ]),
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
