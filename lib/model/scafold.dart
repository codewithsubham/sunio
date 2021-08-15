import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunio/model/gesture.dart';


class ScalfoldExample extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sunio",
          style: GoogleFonts.getFont(
            'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: .5,
        actions: <Widget>[
          IconButton(
              onPressed: (() {
                print("email clicked");
              }),
              icon: Icon(Icons.settings_rounded))
        ],
      ),
      backgroundColor: Colors.deepOrangeAccent,
      body:CostumGesture(),
    );
  }
}


class AspectR  extends StatelessWidget{

  Widget build(BuildContext context){
    return  AspectRatio(
      aspectRatio: 16 / 9,
      child: InkWell(child:Container(
        color: Colors.black,
        child:  Center(
          child:InkWell(child:Text(
            "hello world",
            style: TextStyle(color: Colors.white),
          ),
            onTap: (){
              print("hello world");
            },
          ),

        ),
      ),
        onTap: (){
          print("container");
        },
      ),
    );
  }
}