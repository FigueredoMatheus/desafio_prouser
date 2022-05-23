part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object> get props => [];
}

class LoadingState extends ScannerState {}

class ScannedBarcodeSuccessState extends ScannerState {
  final String barCode;
  ScannedBarcodeSuccessState({required this.barCode});

  @override
  List<Object> get props => [barCode];
}

class ScannedBarcodeFailState extends ScannerState {
  final String errorMsg;

  ScannedBarcodeFailState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class FirebaseSaveFileFail extends ScannerState {
  final String errorMsg;
  final String barcode;

  FirebaseSaveFileFail({
    required this.errorMsg,
    required this.barcode,
  });

  @override
  List<Object> get props => [errorMsg, barcode];
}

class ScanBarcodeState extends ScannerState {}
