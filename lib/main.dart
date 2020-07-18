import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:pusherflu/control.dart';
import 'package:pusherflu/chart.dart';
import 'package:pusherflu/listcardody.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
  List _madata = [];
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
      "tank": 90
    });
    _madata.add({
      "m0": false,
      "m1": false,
      "m2": false,
      "m3": false,
      "m4": false,
      "m5": false,
    });
  }

  int tabin = 0;
  void _tabke(int i) {
    setState(() {
      tabin = i;
    });
  }

  final tombol = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("Kontrol")),
    BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text("Rekap")),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final page = <Widget>[
      Listcardody(_adata, _madata),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: 500, height: 400, child: StackedBarChart.withSampleData()))
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(child: page[tabin]),
      bottomNavigationBar: BottomNavigationBar(
        items: tombol,
        currentIndex: tabin,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _tabke,
      ),
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
          "S4": 0,
          "S5": 0,
          "L0": udata['L0'],
          "L1": udata['L1'],
          "L2": udata['L2'],
          "L3": udata['L3'],
          "L4": 0,
          "L5": 0,
          "sel0": "on",
          "sel1": "on",
          "sel2": "on",
          "sel3": "off",
          "tank": udata['tank']
        });
        if (udata['S5'] == null) {
          //kondisi ini dipakai untuk dinamis, ketika admin menambah kan sensor dht22 lagi
          print('s5 kosong');
        }
        // print(_adata);
        // }
      });
    });
    _pChannel.bind("tombol", (val) {
      final mudata = json.decode(val.data);
      // print(mudata['m0']);
      setState(() {
        _madata = [];
        _madata.add({
          "m0": mudata["m0"],
          "m1": mudata["m1"],
          "m2": mudata["m2"],
          "m3": mudata["m3"],
          "m4": mudata["m4"],
          "m5": mudata["m5"]
        });
        // createAlbum(val);
      });
    });
  }
}
