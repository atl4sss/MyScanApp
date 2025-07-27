/* lib/core/theme.dart */
import 'package:flutter/material.dart';

const kBlue     = Color(0xFF1E88E5);
const kBlue2    = Color(0xFF42A5F5);
const kGreyTxt  = Color(0xFF555C6D);
const kHintBg   = Color(0xFFF1F4F8);
const kTextBlack  = Color.fromARGB(255, 0, 0, 0);   // насыщённый, почти чистый чёрный

final textTheme = TextTheme(
  // крупные заголовки
  headlineLarge : const TextStyle(
      fontFamily: 'SamsungSharpSans',
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: kTextBlack),
  headlineMedium: const TextStyle(
      fontFamily: 'SamsungSharpSans',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: kTextBlack),
  // обычный текст
  bodyLarge : const TextStyle(
      fontFamily: 'Gothic',
      fontSize: 16,
      color: kTextBlack),
  bodyMedium: const TextStyle(
      fontFamily: 'Gothic',
      fontSize: 14,
      color: kGreyTxt),
);

const titleStyle    = TextStyle(fontFamily: 'SamsungSharpSans', fontSize: 32, fontWeight: FontWeight.w700);
const sectionStyle  = TextStyle(fontFamily: 'Gothic', fontSize: 14, color: kGreyTxt, fontWeight: FontWeight.w600);
