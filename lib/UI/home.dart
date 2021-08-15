import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sunio/model/MessageWhileDownlading.dart';
import 'package:sunio/model/pipeserver.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _mediaLink = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _downloadProgress = 0.0;
  bool _showLoader = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 1,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                    controller: _mediaLink,
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: Builder(
                    builder: (contexts) => TextButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: const Text('Yay! A SnackBar!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                       // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          _test(contexts);
                      },
                      child: (!_showLoader)
                          ? Text("Get")
                          : SizedBox(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, value: _downloadProgress),
                              width: 20,
                              height: 20,
                            ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amberAccent)),
                    ),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Builder(
          builder: (context) => TextButton(
            child: Text("asdasd"),
            onPressed: () {
              print(context);
              final snackBar = SnackBar(
                content: const Text('Yay! A SnackBar!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      ),
    );
  }

  void _test(BuildContext context) {

    return  ShowMessage.onErrorMessage(context, "could not donwload");
    String url = _mediaLink.text;
    Sse event = Sse.connect(musicUri: url);

    event.eventSource.onOpen.listen((event) {
      setState(() {
        _showLoader = true;
      });
    });

    event.stream.listen((data) {
      Map<String, dynamic> payload = jsonDecode(data.toString());

      if (payload['err']) {
        print(payload['errMessage']);
        event.close();
        setState(() {
          _showLoader = false;
        });
        ShowMessage.onErrorMessage(context, payload['errMessage']);

        return;
      }
        if (payload['completed']) {
          event.close();
          setState(() {
            _showLoader = false;
          });
          ShowMessage.onCompletedMessage(context);
          return;
        }
        setState(() {
          _downloadProgress = double.parse(
              payload['pertentage']); //double.parse(data.toString());
        });
      }
    );
  }
}
