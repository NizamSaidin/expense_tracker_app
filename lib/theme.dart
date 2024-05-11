import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff116682),
      surfaceTint: Color(0xff116682),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbde9ff),
      onPrimaryContainer: Color(0xff001f2a),
      secondary: Color(0xff4d616c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd0e6f2),
      onSecondaryContainer: Color(0xff081e27),
      tertiary: Color(0xff5d5b7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe3dfff),
      onTertiaryContainer: Color(0xff191836),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff6fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787d),
      outlineVariant: Color(0xffc0c8cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffedf1f5),
      inversePrimary: Color(0xff8bd0ef),
      primaryFixed: Color(0xffbde9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff8bd0ef),
      onPrimaryFixedVariant: Color(0xff004d64),
      secondaryFixed: Color(0xffd0e6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad6),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc6c2ea),
      onTertiaryFixedVariant: Color(0xff454364),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00495e),
      surfaceTint: Color(0xff116682),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff337d99),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff31464f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff637882),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff413f60),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff737195),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff3c4448),
      outline: Color(0xff586065),
      outlineVariant: Color(0xff747c80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffedf1f5),
      inversePrimary: Color(0xff8bd0ef),
      primaryFixed: Color(0xff337d99),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0b647f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff637882),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a5f69),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff737195),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5a587b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002633),
      surfaceTint: Color(0xff116682),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00495e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0f252e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff31464f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff201f3d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff413f60),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff1d2529),
      outline: Color(0xff3c4448),
      outlineVariant: Color(0xff3c4448),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffd5f0ff),
      primaryFixed: Color(0xff00495e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003141),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff31464f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1b2f38),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff413f60),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2b2949),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bd0ef),
      surfaceTint: Color(0xff8bd0ef),
      onPrimary: Color(0xff003546),
      primaryContainer: Color(0xff004d64),
      onPrimaryContainer: Color(0xffbde9ff),
      secondary: Color(0xffb4cad6),
      onSecondary: Color(0xff1f333c),
      secondaryContainer: Color(0xff354a53),
      onSecondaryContainer: Color(0xffd0e6f2),
      tertiary: Color(0xffc6c2ea),
      onTertiary: Color(0xff2e2d4d),
      tertiaryContainer: Color(0xff454364),
      onTertiaryContainer: Color(0xffe3dfff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdfe3e7),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdfe3e7),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xffc0c8cd),
      outline: Color(0xff8a9297),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inverseOnSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff116682),
      primaryFixed: Color(0xffbde9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff8bd0ef),
      onPrimaryFixedVariant: Color(0xff004d64),
      secondaryFixed: Color(0xffd0e6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad6),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc6c2ea),
      onTertiaryFixedVariant: Color(0xff454364),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8fd4f3),
      surfaceTint: Color(0xff8bd0ef),
      onPrimary: Color(0xff001923),
      primaryContainer: Color(0xff5399b7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb8ceda),
      onSecondary: Color(0xff031921),
      secondaryContainer: Color(0xff7f949f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcac7ef),
      onTertiary: Color(0xff141231),
      tertiaryContainer: Color(0xff8f8db2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdfe3e7),
      surface: Color(0xff0f1417),
      onSurface: Color(0xfff7fbff),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xffc4ccd1),
      outline: Color(0xff9ca4a9),
      outlineVariant: Color(0xff7c8489),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inverseOnSurface: Color(0xff262b2e),
      inversePrimary: Color(0xff004e65),
      primaryFixed: Color(0xffbde9ff),
      onPrimaryFixed: Color(0xff00131c),
      primaryFixedDim: Color(0xff8bd0ef),
      onPrimaryFixedVariant: Color(0xff003b4d),
      secondaryFixed: Color(0xffd0e6f2),
      onSecondaryFixed: Color(0xff00131c),
      secondaryFixedDim: Color(0xffb4cad6),
      onSecondaryFixedVariant: Color(0xff243942),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff0f0d2b),
      tertiaryFixedDim: Color(0xffc6c2ea),
      onTertiaryFixedVariant: Color(0xff343353),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff7fbff),
      surfaceTint: Color(0xff8bd0ef),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8fd4f3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff7fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb8ceda),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffef9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcac7ef),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdfe3e7),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xfff7fbff),
      outline: Color(0xffc4ccd1),
      outlineVariant: Color(0xffc4ccd1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002e3d),
      primaryFixed: Color(0xffc8ecff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8fd4f3),
      onPrimaryFixedVariant: Color(0xff001923),
      secondaryFixed: Color(0xffd4eaf6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb8ceda),
      onSecondaryFixedVariant: Color(0xff031921),
      tertiaryFixed: Color(0xffe8e4ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcac7ef),
      onTertiaryFixedVariant: Color(0xff141231),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
