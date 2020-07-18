// import 'dart:convert';

import 'dart:convert';

// import 'package:pusher/pusher.dart';
import 'package:http/http.dart' as http;

class Customer {
  String name;
  bool booll;

  Customer(this.name, this.booll);

  @override
  String toString() {
    return '{ ${this.name}, ${this.booll} }';
  }
}

Future<void> mmain(Map data) async {
  // List list = List();
  // Pusher pu = new Pusher('1028730', 'e2b086b799d195c9cf48',
  //     'bff0d130e00935b3d2bd', PusherOptions(cluster: 'ap1'));
  // Map data = {'"$ind"': tf};
  // createAlbum(data);
  // print(json.encode(data));
  // print(json.encode(json.decode(json.encode(data))));
  // Map<String, String> result = {};
  // var datas ;
  // for (var datas in data) {
  //   print(datas.toString() + "" + data.length.toString());
  // }
  String dasta = jsonEncode(data);
  print(dasta);
  // data = json.encode(data) as Map;
  await http.post('https://odi.sdnlada2.sch.id/tombol.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data));
  // await pu.trigger(['channelTa'], 'tombol', data);
}

// Future<http.Response> createAlbum(dynamic datas) async {
//   // Tomap so = Tomap();
//   // final dats = json.decode(data);
//   final data = json.decode(datas.data);
//   return http
//       .post('https://odi.sdnlada2.sch.id/index.php', headers: <String, String>{
//     'Content-Type': 'application/x-www-form-urlencoded',
//   }, body: {
//     'm0': data["m0"],
//     'm1': data["m1"],
//     'm2': data["m2"],
//     'm3': data["m3"],
//     'm4': data["m4"],
//     'm5': data["m5"],
//   });
// }
