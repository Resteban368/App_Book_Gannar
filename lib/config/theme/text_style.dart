import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/theme/theme_bloc.dart';
import 'app_theme.dart';

class TextStyles {
  static const TextStyle medium = TextStyle(
    fontSize: 14,
    fontFamily: "Poppins",
    color: MyColors.white,
  );

  static TextStyle mediumBlack(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return TextStyle(
      color: themeState.theme == AppTheme.light
          ? const Color(0xFF4C4A4A)
          : Colors.white,
      fontSize: 14,
      fontFamily: "Poppins",
    );
  }

  static TextStyle mediumBlackTitle(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return TextStyle(
      fontSize: 16,
      fontFamily: "Poppins",
      fontWeight: FontWeight.bold,
      color: themeState.theme == AppTheme.light
          ? const Color(0xFF4C4A4A)
          : Colors.white,
    );
  }

  static const TextStyle mediumLigth = TextStyle(
    fontSize: 14,
    fontFamily: "Poppins",
    color: MyColors.black,
  );
  static const TextStyle info = TextStyle(
    fontSize: 10,
    fontFamily: "Poppins",
    color: //4C4A4A
        Color(0xFF4C4A4A),
  );
  static const TextStyle mediumPrimary = TextStyle(
      fontSize: 14,
      fontFamily: "Poppins",
      color: //4C4A4A
          MyColors.primary);
  static const TextStyle mediumPrimaryTitle = TextStyle(
      fontSize: 16,
      fontFamily: "Poppins",
      color: //4C4A4A
          MyColors.primary);

  static const TextStyle price = TextStyle(
      fontSize: 20,
      fontFamily: "Poppins",
      color: //4C4A4A
          MyColors.primary);
}
