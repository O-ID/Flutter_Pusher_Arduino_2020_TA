import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pusherflu/chart.dart';
import 'package:pusherflu/claschart.dart';
import 'package:pusherflu/gatau.dart';
import 'package:pusherflu/listcardody.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('ru'),
        Locale('ja'),
        Locale('ar'),
        Locale('fa'),
        Locale("es"),
      ],
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
  List _adata = [];
  List _madata = [];
  bool stindi = false;
  List<ClassChart> data = [
    ClassChart(sensor: 'DHT 1', datas: 0),
    ClassChart(sensor: 'DHT 2', datas: 0),
    ClassChart(sensor: 'DHT 3', datas: 0),
    ClassChart(sensor: 'DHT 4', datas: 0),
    ClassChart(sensor: 'DHT 5', datas: 0),
    ClassChart(sensor: 'DHT 6', datas: 0),
    ClassChart(sensor: 'AIR', datas: 0),
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var ss;
  String tampilkan = 'Pilih Bulan Untuk Melihat Data Pengembunan';
  DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    _konekpusher();
    dLoad();
    selectedDate = DateTime.now();
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
    BottomNavigationBarItem(
        icon: Icon(Icons.add_to_queue), title: Text("Info")),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final page = <Widget>[
      Listcardody(_adata, _madata),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            stretch: false,
            backgroundColor: Colors.purple[50],
            flexibleSpace: FlexibleSpaceBar(
              background:
                  Image.asset('assets/images/icon.png', fit: BoxFit.contain),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(-200),
                bottomRight: Radius.circular(200),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                height: 190,
                // color: Colors.black,
                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment(0.80, -0.10),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.purple,
                                  style: BorderStyle.solid,
                                  width: 0.60),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  showMonthPicker(
                                          context: context,
                                          firstDate: DateTime(
                                              DateTime.now().year - 1, 5),
                                          lastDate: DateTime(
                                              DateTime.now().year + 1, 9),
                                          initialDate: selectedDate,
                                          locale: Locale('en'))
                                      .then((date) {
                                    if (date != null) {
                                      // _showMyDialog(date, "Pilih Data Rekap",
                                      //     "Lanjutkan Memilih ", false);
                                      var s =
                                          int.parse(date.month.toString()) < 10
                                              ? "0" + date.month.toString()
                                              : date.month.toString();
                                      _loadFrekap(
                                          date.year.toString() + "-" + s,
                                          false);
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    }
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.calendar_today),
                                    Text('Lihat Data')
                                  ],
                                )))),
                    Align(
                        alignment: Alignment(-0.80, -0.10),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.purple,
                                  style: BorderStyle.solid,
                                  width: 0.60),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  showMonthPicker(
                                          context: context,
                                          firstDate: DateTime(
                                              DateTime.now().year - 1, 5),
                                          lastDate: DateTime(
                                              DateTime.now().year + 1, 9),
                                          initialDate: selectedDate,
                                          locale: Locale('en'))
                                      .then((date) {
                                    if (date != null) {
                                      _showMyDialog(date, "Hapus Data",
                                          "Anda Yakin Ingin Menghapus ", true);
                                      // setState(() {
                                      //   selectedDate = date;
                                      // });
                                    }
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.delete_forever),
                                    Text('Hapus Data')
                                  ],
                                )))),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(tampilkan),
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
      Psolving()
    ];
    return Scaffold(
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

  Future<void> _loadFrekap(String isian, bool izy) async {
    final respon = await http.post('https://odi.sdnlada2.sch.id/f_rekap.php',
        body: {'dcode': isian, 'bole': izy ? 't' : ''});
    if (respon.statusCode == 200) {
      final a = json.decode(respon.body);
      // print(json.decode(respon.body)[1]['sensor']);
      if (!izy) {
        setState(() {
          tampilkan = "Data Pada Bulan " + isian;
          data.clear();
          for (Map i in a) {
            data.add(ClassChart(
                sensor: Album.fromJson(i).sensor,
                datas: Album.fromJson(i).onn));
          }
          stindi = false;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Respon Sistem !!!'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Data $isian ${a[0]["hasil"]} Di Hapus')
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      }
    }
  }

  Future<void> _showMyDialog(
      DateTime date, String title, String pesan, bool iss) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    pesan + '${date.month.toString()}/${date.year.toString()}'),
                Text('Silahkan Pilih  Ok/Cancel'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                var s = int.parse(date.month.toString()) < 10
                    ? "0" + date.month.toString()
                    : date.month.toString();
                setState(() {
                  selectedDate = date;
                  _loadFrekap(date.year.toString() + "-" + s, iss);
                  tampilkan = "Data Pada Bulan " +
                      date.month.toString() +
                      "-" +
                      date.year.toString();
                });
              },
            ),
          ],
        );
      },
    );
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
