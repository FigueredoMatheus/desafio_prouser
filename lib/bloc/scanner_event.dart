part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannedCodeEvent extends ScannerEvent {
  final Barcode barCode;

  ScannedCodeEvent({
    required this.barCode,
  });

  @override
  List<Object> get props => [barCode];
}
