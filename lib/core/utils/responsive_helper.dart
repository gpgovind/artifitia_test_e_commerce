import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getResponsiveFontSize(
      BuildContext context, double baseFontSize) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 768) return baseFontSize;
    if (screenWidth < 1024) return baseFontSize * 1.2;
    return baseFontSize * 1.4;
  }

  static double getResponsiveWidth(BuildContext context, double baseWidth) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 768) return baseWidth;
    if (screenWidth < 1024) return baseWidth * 1.3;
    return baseWidth * 1.5;
  }

  static double getResponsiveHeight(BuildContext context, double baseHeight) {
    double screenHeight = getScreenHeight(context);
    if (screenHeight < 800) return baseHeight * 0.8;
    if (screenHeight < 1200) return baseHeight;
    return baseHeight * 1.2;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    if (screenWidth < 768) return const EdgeInsets.symmetric(horizontal: 16.0);
    if (screenWidth < 1024) return const EdgeInsets.symmetric(horizontal: 32.0);
    return const EdgeInsets.symmetric(horizontal: 64.0);
  }
}
