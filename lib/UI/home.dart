import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sunio/model/MessageWhileDownlading.dart';
import 'package:sunio/model/pipeserver.dart';

import 'appBar.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(MediaQuery
                  .of(context)
                  .size
                  .height * .08),
              child: CustomAppBar()
          ),
          body: Text("asdasd")
      ),
    );
  }
}
