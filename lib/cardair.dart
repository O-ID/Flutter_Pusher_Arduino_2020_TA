import 'package:flutter/material.dart';
import 'package:pusherflu/control.dart';

class Cardair extends StatefulWidget {
  // Cardair(List adata);

  final List<dynamic> dataku;
  final List<dynamic> mdata;
  Cardair(this.dataku, this.mdata, {Key key});
  _CardairState createState() => _CardairState();
}

class _CardairState extends State<Cardair> {
  final Map<String, dynamic> tbl = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
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
                        alignment: Alignment(-0.75, -0.75),
                        child: Text(
                          "Ketersediaan Air",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   color: Colors.grey,
                // ),
                Container(
                  padding: EdgeInsets.all(0.0),
                  width: double.maxFinite,
                  height: 160.0,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment(-0.79, -0.64),
                        child: Text(
                          widget.dataku[0]['tank'].toString(),
                          style: TextStyle(
                              fontSize: 78.0,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 3.0,
                                    color: Colors.grey)
                              ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.29, 0.02),
                        child: Text(
                          "%",
                          style: TextStyle(
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 3.0,
                                    color: Colors.grey)
                              ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.80, -1.00),
                        child: Container(
                          width: 200.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all()),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.97, 0.76),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            "Manual",
                            style: TextStyle(fontSize: 17.00),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.20, 0.98),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Switch(
                                value: widget.mdata[0]['tkk'],
                                onChanged: (value) {
                                  setState(() {
                                    widget.mdata[0]['tkk'] = value;
                                    for (var i = 0; i < 7; i++) {
                                      if (i != 6) {
                                        tbl['m$i'] = widget.mdata[0]['m$i'];
                                      } else {
                                        tbl['tkk'] = widget.mdata[0]['tkk'];
                                      }
                                      // widget.mdata.
                                    }
                                    // print(widget.mdata);
                                    mmain(tbl);
                                  });
                                }),
                          ))
                    ],
                  ),
                ),
              ])),
    );
  }
}
