import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/app_theme.dart';
import '../auth/login/bloc/login_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String displayedText = ""; // El texto que se mostrará progresivamente
  int currentIndex = 0; // Índice actual del texto
  late Timer typeTimer; // Temporizador para simular la escritura

  @override
  void initState() {
    super.initState();
    startTypingAnimation();
  }

  @override
  void dispose() {
    typeTimer.cancel(); // Cancela el temporizador cuando se destruye el widget
    super.dispose();
  }

  void startTypingAnimation() {
    typeTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (currentIndex < fullText.length) {
        setState(() {
          displayedText = fullText.substring(0, currentIndex + 1);
          currentIndex++;
        });
      } else {
        currentIndex = 0; // Reinicia el índice para comenzar desde el principio
        displayedText = ""; // Reinicia el texto
      }
    });
  }

  String fullText =
      "Gannar"; // El texto completo que se mostrará progresivamente

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return  Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                //circulo grande
                FondoSplasApp(displayedText: displayedText),

                Positioned(
                  left: 0,
                  top: 470,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    child: Column(
                      children: [
                        const Text(
                          "Encuentra tu libro y explora mundos infinitos",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black87,
                            fontFamily: "poppins",
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Miles de libros en Gannar. Aprende cosas nuevas, explora diferentes ideas y amplia tus conocimientos.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontFamily: "poppins",
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        BounceInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: ElevatedButton(
                            onPressed: () {
                              context.go("/login");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              minimumSize: Size(size.width * 0.8, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("Iniciar",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: "poppins",
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //btn de continuar
              ],
            ),
          ),
        );
  }
}

class FondoSplasApp extends StatelessWidget {
  const FondoSplasApp({
    super.key,
    required this.displayedText,
  });

  final String displayedText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -150,
          top: -300,
          child: Container(
            width: 700,
            height: 700,
            decoration: const BoxDecoration(
              color: MyColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          left: 85,
          top: 100,
          child: Text(
            displayedText,
            style: const TextStyle(
              fontSize: 70,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
        ),

        //imagen
        Positioned(
          left: 50,
          top: 200,
          child: Image.asset(
            "assets/images/book.png",
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
