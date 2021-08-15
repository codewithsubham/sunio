import 'package:flutter/material.dart';

class CostumGesture extends StatelessWidget{
    final _snackbar = new SnackBar(content:Row(
      children: <Widget>[
        // add your preferred icon here
        Icon(
          Icons.close,
          color: Colors.white,
        ),
        // add your preferred text content here
        Text("subham"),
      ],
    ),  backgroundColor: Colors.red,);
    Widget build(BuildContext context){
        return GestureDetector(
          onTap: () {
           // Scaffold.of(context).showSnackBar(_snackbar);
            ScaffoldMessenger.of(context).showSnackBar(_snackbar);
           // print("hello world");
          },
          child:Center(
            child: FittedBox(child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff1D1C2B),
              ),
              padding:const  EdgeInsets.symmetric(vertical: 020.0 , horizontal: 20),
                child: Text("subham" , style: TextStyle(color: Colors.white),),
             ),
          ) ,),
        );
    }


}