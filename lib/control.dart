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
  String dasta = jsonEncode(data);
  print(dasta);
  // data = json.encode(data) as Map;
  await http.post('https://odi.sdnlada2.sch.id/tombol.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data));
  // await pu.trigger(['channelTa'], 'tombSol', data);
}
