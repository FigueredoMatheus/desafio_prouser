import 'package:desafio_prouser/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

codeScanSuccess({
  required BuildContext context,
  required String code,
  required String msg,
}) {
  showDialog(
      context: context,
      builder: (context) {
        bool isUrl = code.contains('http');
        return AlertDialog(
          title: Text(msg),
          content: InkWell(
            onTap: isUrl ? () => launchUrl(Uri.parse(code)) : null,
            child: Text(
              code,
              style: TextStyle(
                color: Colors.black,
                decoration: isUrl ? TextDecoration.underline : null,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesNames.scannerScreen,
                  (route) => false,
                );
              },
              child: const Text('Ler novamente'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesNames.homeScreen,
                (route) => false,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      });
}
