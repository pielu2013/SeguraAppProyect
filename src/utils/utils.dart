
import 'package:flutter/material.dart';

void mostarAlerta(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text ('Información incorrecta'),
        content: Text(mensaje),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

bool isNumeric ( String s ) {
  if(s.isEmpty) return false;

  final n = num.tryParse(s);

  return ( n == null ) ? false : true;
}