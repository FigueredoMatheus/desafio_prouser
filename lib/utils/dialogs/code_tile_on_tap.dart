import 'package:desafio_prouser/controllers/storage_controller.dart';
import 'package:desafio_prouser/models/code_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

codeTileOnTap({
  required BuildContext context,
  required CodeModel codeModel,
  required String formatedDate,
}) {
  showDialog(
      context: context,
      builder: (context) {
        bool isUrl = codeModel.code.contains('http');
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap:
                    isUrl ? () => launchUrl(Uri.parse(codeModel.code)) : null,
                child: Text(
                  codeModel.code,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: isUrl ? TextDecoration.underline : null,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formatedDate,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                StorageController.deleteFile(
                  context: context,
                  codeId: codeModel.id,
                );
                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      });
}
