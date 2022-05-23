import 'package:desafio_prouser/routes/routes_names.dart';
import 'package:flutter/material.dart';

scanBarcodeFail(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Falha ao ler o código de barras.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
