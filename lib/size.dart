import 'package:flutter/material.dart';

double heigth(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
double paddingTop(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
