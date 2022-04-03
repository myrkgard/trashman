import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:trashman/service.dart';
// import 'package:http/http.dart' as http;

const _germanWeekdayNames = <int, String>{
  1: 'Montag',
  2: 'Dienstag',
  3: 'Mittwoch',
  4: 'Donnerstag',
  5: 'Freitag',
  6: 'Samstag',
  7: 'Sonntag',
};

String _germanType(TrashType t) {
  switch (t) {
    case TrashType.papier:
      return 'Blaue Tonne';
    case TrashType.restmuell:
      return 'Schwarze Tonne';
    case TrashType.wertstoff:
      return 'Orangene Tonne';
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TrashPair? _tp;
  String title = 'Trashman';

  void _onTick() {
    setState(() {
      _tp = findNext();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 1), (_) => _onTick());
    _onTick();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nächste Leerung:',
              textScaleFactor: 1.6,
            ),
            const SizedBox(height: 24),
            if (_tp == null)
              const Text(
                'unbekannt',
                textScaleFactor: 1.4,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            if (_tp != null)
              Text(
                '${_germanWeekdayNames[_tp!.date.weekday()]}, ${_tp!.date.toIso8601()}',
                textScaleFactor: 1.4,
              ),
            const SizedBox(height: 16),
            if (_tp != null)
              Text(
                _germanType(_tp!.type),
                textScaleFactor: 1.4,
              ),
            // const SizedBox(height: 100),
            // ElevatedButton(
            //     onPressed: () async {
            //       try {
            //         final response = await http.get(
            //             Uri.http('192.168.0.231:52324', '/123456-poweroff'));
            //         if (response.statusCode == 200) {
            //           setState(() {
            //             title = 'OKAY';
            //           });
            //         }
            //       } catch (e) {
            //         setState(() {
            //           title = 'NOT OKAY';
            //         });
            //       }
            //     },
            //     child: const Text('Computer ausschalten')),
          ],
        ),
      ),
    ));
  }
}
