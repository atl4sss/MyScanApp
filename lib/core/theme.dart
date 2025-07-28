// lib/core/theme.dart
import 'package:flutter/material.dart';

/// Радиусы, отступы и акценты
const kRadius = 18.0;
const kBlue = Color(0xFF5291FF);      // новый основной синий
const _seed  = Color(0xFF5291FF);

/// Главный градиент для FAB, баннеров и кнопок
const kPrimaryGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF5291FF),
    Color(0xFFC0D9FF),
  ],
);

// Дополнительные цвета
const kTextBlack = Color(0xFF1C1F24);
const kGreyTxt   = Color(0xFF7C8795);

ThemeData lightTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.light,
    surfaceTint: _seed.withOpacity(.10),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    primaryColor: kBlue,
    scaffoldBackgroundColor: const Color(0xFFFAFBFF),

    // Сброс шрифтов на локальные Gotham/Gothic
    fontFamily: 'Gothic',

    textTheme: TextTheme(
      // Крупные заголовки — SamsungSharpSans
      headlineMedium: const TextStyle(
        fontFamily: 'SamsungSharpSans',
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: kTextBlack,
        height: 1.15,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'SamsungSharpSans',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: kTextBlack,
      ),
      // Основной текст — Gothic
      bodyLarge: const TextStyle(
        fontFamily: 'Gothic',
        fontSize: 15,
        height: 1.35,
        color: kTextBlack,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Gothic',
        fontSize: 14,
        height: 1.4,
        color: scheme.onSurfaceVariant,
      ),
    ),

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: scheme.surface,
      foregroundColor: kBlue,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontFamily: 'SamsungSharpSans',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: kBlue,
      ),
    ),

    cardTheme: CardThemeData(
      color: scheme.surface,
      surfaceTintColor: scheme.surfaceTint,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: BorderSide(color: kBlue, width: 1.6),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        elevation: 0,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        elevation: 0,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      iconTheme:
      MaterialStatePropertyAll(IconThemeData(size: 28, color: kBlue)),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      indicatorColor: kBlue.withOpacity(.18),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      labelTextStyle: MaterialStatePropertyAll(
        const TextStyle(
          fontFamily: 'SamsungSharpSans',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withOpacity(.6),
      space: 0,
    ),
  );
}

ThemeData darkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.dark,
  );

  return lightTheme().copyWith(
    colorScheme: scheme,
    scaffoldBackgroundColor: const Color(0xFF0F1115),
    appBarTheme: lightTheme().appBarTheme.copyWith(
      foregroundColor: kBlue,
      titleTextStyle: lightTheme().appBarTheme.titleTextStyle?.copyWith(
        color: kBlue,
      ),
    ),
  );
}
