import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Odybulan extends StatefulWidget {
  final DateTime initialDate;

  const Odybulan({Key key, @required this.initialDate}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Odybulan> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

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
      theme:
          ThemeData(primarySwatch: Colors.purple, accentColor: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Month Picker Example App'),
        ),
        body: Center(
          child: Text(
            'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: selectedDate ?? widget.initialDate,
                locale: Locale("en"),
              ).then((date) {
                if (date != null) {
                  _showMyDialog(date);
                  // setState(() {
                  //   selectedDate = date;
                  // });
                }
              });
            },
            child: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(DateTime date) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Anda yakin ingin Memilih ${date.month.toString()}/${date.year.toString()}'),
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
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
