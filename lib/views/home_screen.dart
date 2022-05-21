import 'package:desafio_prouser/routes/routes_names.dart';
import 'package:desafio_prouser/widgets/homeScreen/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0082E0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                'Desafio ProUser',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              NavigationButton(
                title: 'Ler código',
                onPressed: () => Navigator.pushNamed(
                  context,
                  RoutesNames.scannerScreen,
                ),
              ),
              const SizedBox(height: 20),
              NavigationButton(
                title: 'Códigos lidos',
                onPressed: () => Navigator.pushNamed(
                  context,
                  RoutesNames.codesReadScreen,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
