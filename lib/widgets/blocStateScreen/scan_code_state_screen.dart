import 'package:desafio_prouser/bloc/scanner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeStateScreen extends StatelessWidget {
  const ScanCodeStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();
    final double scanSize = MediaQuery.of(context).size.width * 0.70;
    return Stack(
      children: [
        Center(
          child: Container(
            width: scanSize,
            height: scanSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                context.read<ScannerBloc>().add(
                      ScannedCodeEvent(
                        barCode: barcode,
                      ),
                    );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ),
      ],
    );
  }
}
