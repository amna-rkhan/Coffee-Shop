import 'package:flutter/material.dart';

extension SizeExtension on num {
  double h(BuildContext context) => this * MediaQuery.of(context).size.height / 100;
  double w(BuildContext context) => this * MediaQuery.of(context).size.width / 100;
}