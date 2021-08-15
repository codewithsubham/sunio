import 'dart:ui';

import "package:flutter/material.dart";



class StateFullExample extends StatefulWidget{

    _StateFullExampleState createState() => _StateFullExampleState();
}


class _StateFullExampleState extends State<StateFullExample>{

  int number  = 0;

  void _increment() {

    setState(() {
      number++;

    });

  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("sunio"),),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .98,
                height: MediaQuery.of(context).size.height * .30,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text(number.toString(), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: number.toDouble()),),
                ),
              ),
            ),
            TextButton(onPressed: _increment, child: Text("click"))
        ],
      )
    );
  }

}