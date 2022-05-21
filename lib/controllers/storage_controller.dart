import 'package:desafio_prouser/controllers/app_state_controller.dart';
import 'package:desafio_prouser/firebase/cloud_firestore.dart';
import 'package:desafio_prouser/models/code_model.dart';
import 'package:desafio_prouser/utils/dialogs/alert.dart';
import 'package:desafio_prouser/utils/dialogs/code_scan_fail.dart';
import 'package:desafio_prouser/utils/dialogs/code_scan_success.dart';
import 'package:desafio_prouser/utils/dialogs/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:desafio_prouser/data/codes_read_list.dart';

class StorageController {
  static scanSuccess({
    required BuildContext context,
    required String code,
  }) async {
    loading(context, 'Carregando...');

    final Map<String, dynamic> codeModel = {
      'code': code,
      'date': DateTime.now(),
    };

    await CloudFirestore.saveFile(codeModel).then((result) {
      Navigator.pop(context);
      if (!result['success']) {
        codeScanSuccess(
          context: context,
          code: code,
          msg:
              'Código lido com sucesso, porém houve uma falha ao armazenar no banco de dados.',
        );
      } else {
        codesReadList.add(
          CodeModel(
            id: result['docId'],
            code: code,
            date: DateTime.now(),
          ),
        );

        codeScanSuccess(
          context: context,
          code: code,
          msg: 'Código lido e armazenado com sucesso!',
        );
      }
    });
  }

  static scanFail({
    required BuildContext context,
  }) {
    codeScanFail(context);
  }

  static deleteFile({
    required BuildContext context,
    required String codeId,
  }) async {
    final appStateController = AppStateController();
    loading(context, 'Excluindo...');

    await CloudFirestore.deleteFile(codeId).then((result) {
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
