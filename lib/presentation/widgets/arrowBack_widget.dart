import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_theme.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
    required this.goBack,
  });
  final String goBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(goBack);
        
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          color: MyColors.white,
          //sombra debajo del boton
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: const Icon(
          Icons.keyboard_double_arrow_left_rounded,
          color: MyColors.primary,
          size: 30,
        ),
      ),
    );
  }
}
