import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:pusherflu/control.dart';

import 'cardair.dart';
import 'listku.dart';

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
      "L0": 45.80,
      "L1": 54.90,
      "L2": 34.78,
      "L3": 90.77,
      "SEL1": 'on',
      "SEL2": 'on',
      "SEL3": 'on',
      "SEL4": 'off',
      "m0": true,
      "m1": false,
      "m2": true,
      "m3": true,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Column(
            children: <Widget>[
              Expanded(child: new Listcard(_adata)),
            ],
            //     child: Stack(
            //   children: <Widget>[new Listcard(_adata), new Cardair(_adata)],
            // )
          );
        },
      ),
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
          "L0": udata['L0'],
          "L1": udata['L1'],
          "L2": udata['L2'],
          "L3": udata['L3'],
          "sel0": "on",
          "sel1": "on",
          "sel2": "on",
          "sel3": "off",
          "m0": udata['m0'],
          "m1": udata['m1'],
          "m2": udata['m2'],
          "m3": udata['m3'],
          "tank": 90
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
