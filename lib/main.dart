import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pusherflu/chart.dart';
import 'package:pusherflu/claschart.dart';
import 'package:pusherflu/listcardody.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
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
  String _valGender = "Januari";
  List _adata = [];
  List _madata = [];
  bool stindi = true;
  List<ClassChart> data = [
    ClassChart(sensor: 'DHT 1', datas: 19),
    ClassChart(sensor: 'DHT 2', datas: 29),
    ClassChart(sensor: 'DHT 3', datas: 39),
    ClassChart(sensor: 'DHT 4', datas: 49),
    ClassChart(sensor: 'DHT 5', datas: 59),
    ClassChart(sensor: 'DHT 6', datas: 69),
    ClassChart(sensor: 'AIR', datas: 79),
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _listGender = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  var ss;
  @override
  void initState() {
    super.initState();
    _konekpusher();
    dLoad();
  }

  int tabin = 0;
  void _tabke(int i) {
    setState(() {
      tabin = i;
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      dLoad();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void dLoad() {
    _adata.add({
      "S0": 0,
      "S1": 0,
      "S2": 0,
      "S3": 0,
      "S4": 0,
      "S5": 0,
      "L0": 0,
      "L1": 0,
      "L2": 0,
      "L3": 0,
      "L4": 0,
      "L5": 0,
      "tank": 0
    });
    _madata.add({
      "m0": false,
      "m1": false,
      "m2": false,
      "m3": false,
      "m4": false,
      "m5": false,
      "tkk": false,
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
      CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Align(
                alignment: Alignment(0.80, 0.00),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 0.60),
                  ),
                  child: DropdownButton(
                    hint: Text("Pilih Bulan"),
                    dropdownColor: Colors.purple[200],
                    value: _valGender,
                    items: _listGender.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _valGender = val;
                        _loadFrekap(_valGender);
                        stindi = true;
                      });
                    },
                  ),
                )),
            Container(
              height: 200,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: 500,
                    height: 400,
                    child: StackedBarChart(dataf: data)))
          ]))
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/icon.png',
          height: 58.0,
          width: 58.0,
          alignment: Alignment.center,
        ),
        backgroundColor: Colors.purple[100], //Color(0xff9575cd),
        elevation: 0.0, //shadow app bar
      ),
      backgroundColor: Colors.purple[100],
      body: stindi
          ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SmartRefresher(
              enablePullDown: true,
              header: WaterDropMaterialHeader(
                distance: 50.0,
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: page[tabin]),
      bottomNavigationBar: BottomNavigationBar(
        items: tombol,
        currentIndex: tabin,
        selectedItemColor: Colors.purple,
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
          "S4": udata['S4'],
          "S5": udata['S5'],
          "L0": udata['L0'],
          "L1": udata['L1'],
          "L2": udata['L2'],
          "L3": udata['L3'],
          "L4": udata['L4'],
          "L5": udata['L5'],
          "tank": udata['tank']
        });
        stindi = false;
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
          "m5": mudata["m5"],
          "tkk": mudata["tkk"]
        });
        // createAlbum(val);
      });
    });
  }

  Future<void> _loadFrekap(String isian) async {
    final respon = await http.post('https://odi.sdnlada2.sch.id/f_rekap.php',
        body: {'dcode': isian});
    // await http.get('https://odi.sdnlada2.sch.id/f_rekap.php');
    if (respon.statusCode == 200) {
      // final o = json.decode(respon.body);
      // print(json.decode(respon.body)[1]);
      final a = json.decode(respon.body);
      setState(() {
        // int dex = 0;
        data.clear();
        for (Map i in a) {
          // dex++;
          data.add(ClassChart(
              sensor: Album.fromJson(i).sensor, datas: Album.fromJson(i).onn));
          // print(Album.fromJson(i).onn);
          // print(dex);
        }
        stindi = false;
        // loading = false;
      });
    }
  }
}

class Album {
  final int id;
  final String sensor;
  final int onn;

  Album({this.id, this.sensor, this.onn});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: int.parse(json['id']),
      sensor: json['sensor'],
      onn: int.parse(json['onn']),
    );
  }
}
