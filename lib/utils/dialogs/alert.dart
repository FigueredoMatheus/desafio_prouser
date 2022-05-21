import 'package:flutter/material.dart';

alert(
  BuildContext context,
  String msg,
) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      });
}
