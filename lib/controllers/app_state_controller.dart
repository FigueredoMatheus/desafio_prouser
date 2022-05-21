import 'package:flutter/cupertino.dart';

class AppStateController {
  static final AppStateController _instance = AppStateController._internal();

  factory AppStateController() {
    return _instance;
  }

  AppStateController._internal();

  bool codesReadListLoaded = false;

  ValueNotifier<bool> attCodesReadScreen = ValueNotifier(false);

  ValueNotifier<int> selectedCode = ValueNotifier(0);

  toggleCodeReadeScreenState() {
    attCodesReadScreen.value = !attCodesReadScreen.value;
  }

  setSelectedCode(int value) {
    selectedCode.value = value;
  }
}
