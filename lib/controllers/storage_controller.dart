import 'package:desafio_prouser/controllers/app_state_controller.dart';
import 'package:desafio_prouser/firebase/cloud_firestore.dart';
import 'package:desafio_prouser/models/code_model.dart';
import 'package:desafio_prouser/utils/dialogs/alert.dart';
import 'package:desafio_prouser/utils/dialogs/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:desafio_prouser/data/codes_read_list.dart';

class StorageController {
  deleteFile({
    required BuildContext context,
    required String codeId,
  }) async {
    final cloudFirestore = CloudFirestore();
    final appStateController = AppStateController();
    loading(context, 'Excluindo...');

    await cloudFirestore.deleteFile(codeId).then((result) {
      Navigator.pop(context);
      if (!result['success']) {
        alert(context, 'Erro ao tentar excluir!');
        return;
      }
      codesReadList.removeWhere(
        (element) => element.id == codeId,
      );
      alert(context, 'Excluido com sucesso!');
      appStateController.toggleCodeReadeScreenState();
    });
  }
}
