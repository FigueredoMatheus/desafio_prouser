import 'package:bloc/bloc.dart';
import 'package:desafio_prouser/controllers/storage_controller.dart';
import 'package:desafio_prouser/data/codes_read_list.dart';
import 'package:desafio_prouser/firebase/cloud_firestore.dart';
import 'package:desafio_prouser/models/code_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final StorageController storageController;
  final CloudFirestore cloudFirestore;

  ScannerBloc({
    required this.storageController,
    required this.cloudFirestore,
  }) : super(ScanBarcodeState()) {
    on<ScannedCodeEvent>(_onScannedCodeEvent);
  }

  _onScannedCodeEvent(
    ScannedCodeEvent event,
    Emitter<ScannerState> emit,
  ) async {
    emit(LoadingState());

    if (event.barCode.rawValue == null) {
      emit(
        ScannedBarcodeFailState(errorMsg: 'Erro ao ler código de barras!'),
      );
    } else {
      final result = await cloudFirestore.saveFile({
        'code': event.barCode.rawValue,
        'date': DateTime.now(),
      });

      if (!result['success']) {
        FirebaseSaveFileFail(
          errorMsg:
              'Código lido com succeso, porém encontrou falhar ao salvar no banco de dados',
          barcode: event.barCode.rawValue!,
        );
      } else {
        codesReadList.add(
          CodeModel(
            id: result['docId'],
            code: event.barCode.rawValue!,
            date: DateTime.now(),
          ),
        );

        emit(ScannedBarcodeSuccessState(barCode: event.barCode.rawValue!));
      }
    }
  }
}
