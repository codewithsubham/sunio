import 'package:flutter/material.dart';
import 'package:sunio/model/pipeserver.dart';

class Home extends StatelessWidget {
  void test() {

    print("called");
    dynamic myStream = Sse.connect(
      uri: Uri.parse('http://localhost:8080/'),
      closeOnError: true,
      withCredentials: false,
    ).stream;

    myStream.listen((event) {
      print('Received:' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ' : ' +
          event.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Material(
      child: Center(
          child: Text(
        "subham",
        textDirection: TextDirection.ltr,
      )),
    );
  }
}
