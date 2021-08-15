import 'dart:async';
import 'dart:convert';

import 'package:universal_html/html.dart' as html;

class Sse {
  final html.EventSource eventSource;
  final StreamController<String> streamController;

  Sse._internal(this.eventSource, this.streamController);

  factory Sse.connect({
    required String musicUri,
    bool withCredentials = false,
    bool closeOnError = true,
  }) {
    // ignore: non_constant_identifier_names
    String URI = "http://192.168.29.183:8080?musicuri=$musicUri";

    final streamController = StreamController<String>();
    final eventSource = html.EventSource(URI);

    eventSource.addEventListener("open",(event)   {

        //streamController.add(jsonEncode({"isConnected": true}));

    });

    eventSource.addEventListener('message', (html.Event message) {
      streamController.add((message as html.MessageEvent).data as String);
    });



    ///close if the endpoint is not working
    if (closeOnError) {
      eventSource.onError.listen((event) {
        eventSource.close();
        streamController.close();
      });
    }
    return Sse._internal(eventSource, streamController);
  }

  Stream get stream => streamController.stream;

  bool isClosed() => this.streamController.isClosed;

  void close() {
    this.eventSource.close();
    this.streamController.close();
  }
}
