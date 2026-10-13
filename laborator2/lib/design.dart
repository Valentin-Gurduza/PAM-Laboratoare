import 'dart:ui' as ui;

import 'package:flutter/material.dart';

abstract final class AppColors {
  static const ink = Color(0xFF191D31);
  static const muted = Color(0xFF8C8E98);
  static const homePrimary = Color(0xFF2BACBE);
  static const primary = Color(0xFF0B8FAC);
  static const secondary = Color(0xFF7BC1B7);
  static const gray = Color(0xFF858585);
  static const tile = Color(0xFFF9F9F9);
  static const appointmentTile = Color(0xFFF4F4F4);
}

TextStyle outfit(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.ink,
  double height = 1.3,
}) => TextStyle(
  fontFamily: 'Outfit',
  fontSize: size,
  fontWeight: weight,
  fontVariations: [ui.FontVariation('wght', weight.value.toDouble())],
  color: color,
  height: height,
  letterSpacing: 0,
);

TextStyle openSans(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = Colors.black,
  double height = 1,
  double? spacing,
}) => TextStyle(
  fontFamily: 'OpenSans',
  fontSize: size,
  fontWeight: weight,
  fontVariations: [ui.FontVariation('wght', weight.value.toDouble())],
  color: color,
  height: height,
  letterSpacing: spacing ?? 0,
);
