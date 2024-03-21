// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gannar/config/theme/app_theme.dart';


class AuthBackground extends StatefulWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground> {
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _FondoBox(),
        Positioned(
          top: 85,
          left: 85,
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
        widget.child,
      ]),
    );
  }
}

class _FondoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      color: MyColors.primary,
      //vamos agregarle un gradiente
      child: const Stack(children: [
        Positioned(
          top: 90,
          left: 30,
          child: _Circle(),
        ),
        Positioned(
          top: -40,
          left: -30,
          child: _Circle(),
        ),
        Positioned(
          top: -50,
          right: -20,
          child: _Circle(),
        ),
        Positioned(
          bottom: -50,
          left: 10,
          child: _Circle(),
        ),
        Positioned(
          bottom: 120,
          right: 20,
          child: _Circle(),
        ),
      ]),
    );
  }
}

//widget para los cirulos
class _Circle extends StatelessWidget {
  const _Circle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
