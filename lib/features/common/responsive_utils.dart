import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double mobileBreakpoint = 1088;
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > mobileBreakpoint;
  }
  
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= mobileBreakpoint;
  }
  
  static bool isDesktopFromConstraints(BoxConstraints constraints) {
    return constraints.maxWidth > mobileBreakpoint;
  }
  
  static bool isMobileFromConstraints(BoxConstraints constraints) {
    return constraints.maxWidth <= mobileBreakpoint;
  }
} 