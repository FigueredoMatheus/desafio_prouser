import 'package:flutter/material.dart';

loading(BuildContext context, String msg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15),
              Text(msg),
            ],
          ),
        );
      });
}
