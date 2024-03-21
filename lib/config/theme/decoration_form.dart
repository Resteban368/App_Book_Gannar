import 'package:flutter/material.dart';
import 'package:gannar/config/theme/app_theme.dart';



class InputDecorations {
  static InputDecoration authInputDecoration({
     String? hintText,
    required String labelText,
    IconData? prefixIcon,
    IconButton? suffixIconButton,
  }) {
    return InputDecoration(
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      fillColor: Colors.white.withOpacity(0.1),
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
        color: MyColors.grisMediano,
      )),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
        color: MyColors.primary,
      )),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
        color: MyColors.primary,
      )),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: MyColors.grisMediano, fontSize: 14),
      hintStyle: const TextStyle(color: MyColors.grisMediano, fontSize: 14),
    
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: MyColors.primary) : null,
      suffixIcon: suffixIconButton,
    );
  }
}
