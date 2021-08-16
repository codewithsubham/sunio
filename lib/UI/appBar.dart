import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sunio/model/MessageWhileDownlading.dart';
import 'package:sunio/model/pipeserver.dart';


class CustomAppBar extends StatefulWidget{


  @override
  State<StatefulWidget> createState() =>  _CustomAppVarState();

}


class _CustomAppVarState extends State<CustomAppBar>{

  final TextEditingController _mediaLink = TextEditingController();

  double _downloadProgress = 0.0;
  bool _showLoader = false;
  @override
  AppBar build(BuildContext context) {
    // TODO: implement build
    return  AppBar(
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
                  onPressed:  (!_showLoader) ? () {
                    _donwload(contexts);
                  } : null,
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
    );
  }


  void _donwload(BuildContext context) {

    // return  ShowMessage.onErrorMessage(context, "could not donwload");
    String url = _mediaLink.text;
    Sse event = Sse.connect(musicUri: url);

    event.eventSource.onOpen.listen((event) {
      setState(() {
        _showLoader = true;
      });
    });

    event.eventSource.onError.listen((event) {
      //print(event);
      ShowMessage.onErrorMessage(context, "could not connect to server");
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