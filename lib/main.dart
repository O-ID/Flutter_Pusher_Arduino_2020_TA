import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'cardair.dart';
// import 'listku.dart';
// import 'listku.dart';
// import 'listku.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Channel _pChannel;
  List _adata = [];
  var ss;
  @override
  void initState() {
    super.initState();
    _konekpusher();
    _adata.add({
      "S0": 39.00,
      "S1": 67.90,
      "S2": 98.90,
      "S3": 45.80,
      "S4": 45.80,
      "S5": 45.80,
      "L0": 45.80,
      "L1": 54.90,
      "L2": 34.78,
      "L3": 90.77,
      "L4": 90.77,
      "L5": 90.77,
      "SEL1": 'on',
      "SEL2": 'on',
      "SEL3": 'on',
      "SEL4": 'off',
      "m0": true,
      "m1": false,
      "m2": true,
      "m3": true,
      "m4": true,
      "m5": true,
      "tank": 90
    });
  }

  int tabin = 0;
  void _tabke(int i) {
    setState(() {
      tabin = i;
    });
  }

  final tombol = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    BottomNavigationBarItem(icon: Icon(Icons.headset), title: Text("Home")),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid.count(
              crossAxisCount: 2,
              children: List.generate(6, (index) {
                int ind = index + 1;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 5,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                "DHT22 Ke-${ind.toString()}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
                                    "${_adata[0]['S' + index.toString()].toString()}°C",
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
                                  "${_adata[0]['L' + index.toString()].toString()}%",
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
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 12.0),
                                child: Text(
                                  _adata[0]['m' + index.toString()] == true
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
                                      value: _adata[0]['m' + index.toString()],
                                      onChanged: (value) {
                                        setState(() {
                                          _adata[0]['m' + index.toString()] =
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
              }),
            ),
            SliverList(delegate: SliverChildListDelegate([Cardair(_adata)]))
          ],
        ),
      ),
      // FutureBuilder(
      // builder: (context, snapshot) {
      //   if (snapshot.hasError) {
      //     print(snapshot.error);
      //   }
      //  CustomScrollView(
      //   slivers: <Widget>[
      //     SliverList(
      //         delegate: SliverChildListDelegate(
      //             [Listcard(_adata), Cardair(_adata)])),
      //     // SliverList(delegate: SliverChildListDelegate([Cardair(_adata)]))
      //   ],
      //   // constraints: BoxConstraints.expand(),
      //   // child: Column(
      //   //   children: <Widget>[
      //   //     // Flexible(child: Listcard(_adata), fit: FlexFit.tight),
      //   //     Listcard(_adata),
      //   //     Cardair(_adata),
      //   //   ],
      //   // ),
      // );
      // },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: tombol,
        currentIndex: tabin,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _tabke,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => mmain(),
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _konekpusher() async {
    //init pusher dulu cek di app key pusher
    try {
      await Pusher.init("e2b086b799d195c9cf48", PusherOptions(cluster: "ap1"));
    } catch (e) {
      print(e);
    }

    //cek koneksinya
    Pusher.connect(
      onConnectionStateChange: (isi) {
        print(isi.currentState);
      },
      onError: (err) {
        print(err.message);
      },
    );

    //channel yang harus di subscribe
    _pChannel = await Pusher.subscribe("channelTa");

    //event atau bind
    _pChannel.bind("eventTa", (val) {
      // print(val.data);
      final udata = json.decode(val.data);
      // Iterable list = udata[0]['message'];
      // data = udata['message'];
      // print(udata.length());
      setState(() {
        ss = udata;
        _adata = [];
        _adata.add({
          "S0": udata['S0'],
          "S1": udata['S1'],
          "S2": udata['S2'],
          "S3": udata['S3'],
          "S4": udata['S4'],
          "S5": udata['S5'],
          "L0": udata['L0'],
          "L1": udata['L1'],
          "L2": udata['L2'],
          "L3": udata['L3'],
          "L4": udata['L4'],
          "L5": udata['L5'],
          "sel0": "on",
          "sel1": "on",
          "sel2": "on",
          "sel3": "off",
          "m0": udata['m0'],
          "m1": udata['m1'],
          "m2": udata['m2'],
          "m3": udata['m3'],
          "m4": udata['m4'],
          "m5": udata['m5'],
          "tank": udata['tank']
        });
        if (udata['S5'] == null) {
          //kondisi ini dipakai untuk dinamis, ketika admin menambah kan sensor dht22 lagi
          print('s5 kosong');
        }
        print(_adata);
        // }
      });
    });
  }
}
