// import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:pusher/pusher.dart';

Future<void> mmain() async {
  Pusher pu = new Pusher('1028730', 'e2b086b799d195c9cf48',
      'bff0d130e00935b3d2bd', PusherOptions(cluster: 'ap1'));
  Map data = {'message': 'Hello world'};
  await pu.trigger(['my_channel'], 'my_event', data);
}
