import 'package:desafio_prouser/bloc/scanner_bloc.dart';
import 'package:desafio_prouser/controllers/storage_controller.dart';
import 'package:desafio_prouser/utils/dialogs/code_scan_fail.dart';
import 'package:desafio_prouser/utils/dialogs/code_scan_success.dart';
import 'package:desafio_prouser/utils/dialogs/loading.dart';
import 'package:desafio_prouser/widgets/blocStateScreen/scan_code_state_screen.dart';
import 'package:desafio_prouser/widgets/blocStateScreen/scanned_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase/cloud_firestore.dart';

class ScanerScreen extends StatefulWidget {
  const ScanerScreen({Key? key}) : super(key: key);

  @override
  State<ScanerScreen> createState() => _ScanerScreenState();
}

class _ScanerScreenState extends State<ScanerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerBloc(
        cloudFirestore: CloudFirestore(),
        storageController: StorageController(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black26,
        body: BlocConsumer<ScannerBloc, ScannerState>(
          listener: (context, state) {
            if (state is LoadingState) {
              loading(context, 'Carregando...');
            }

            if (state is ScannedBarcodeSuccessState) {
              codeScanSuccess(
                context: context,
                msg: 'Código lido e armazenado com sucesso!',
                code: state.barCode,
              );
            }

            if (state is ScannedBarcodeFailState) {
              scanBarcodeFail(context);
            }

            if (state is FirebaseSaveFileFail) {
              codeScanSuccess(
                context: context,
                code: state.barcode,
                msg:
                    'Código lido com sucesso, porém houve uma falha ao armazenar no banco de dados.',
              );
            }
          },
          builder: (context, state) {
            if (state is ScanBarcodeState) {
              return ScanCodeStateScreen();
            }

            return ScannedCodeScreen();
          },
        ),
      ),
    );
  }
}
