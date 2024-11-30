import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils{

  static snakBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  static correctSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  static errorSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

}