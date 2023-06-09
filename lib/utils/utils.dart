import 'package:flutter/material.dart';
import 'package:tiktaktoe/resources/game_method.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.of(context).pop();
            }, child: Text('Play Again')),
          ],
        );
      });
}
