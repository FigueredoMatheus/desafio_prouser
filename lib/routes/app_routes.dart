import 'package:desafio_prouser/routes/routes_names.dart';
import 'package:desafio_prouser/views/codes_read_screen.dart';
import 'package:desafio_prouser/views/home_screen.dart';
import 'package:desafio_prouser/views/scanner_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesNames.scannerScreen:
        return MaterialPageRoute(builder: (context) => const ScanerScreen());
      case RoutesNames.codesReadScreen:
        return MaterialPageRoute(builder: (context) => const CodesReadScreen());

      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
