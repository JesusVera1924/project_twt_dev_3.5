import 'package:flutter/material.dart';

class Responsive {
  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 750;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 750;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double width(double max, double column) {
    //230 del SideBar y 45 restante
    double d = max / 12 * column;
    //print('$d columna $column');
    return d;
  }
}
