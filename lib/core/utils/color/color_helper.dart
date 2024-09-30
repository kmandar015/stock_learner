import 'package:flutter/material.dart';
import 'package:stock_learner/core/shared/colors.dart';

Color determineColorBasedOnChange(double change ) {
  return change < 0 
    ? kNegativeColor 
    : kPositiveColor;
}

TextStyle determineTextStyleBasedOnChange(double change ) {
  return change < 0 
    ?  kNegativeChange
    : kPositiveChange;
}

const TextStyle kPositiveChange = TextStyle(
  color: kPositiveColor,
  fontSize: 16,
  fontWeight: FontWeight.w800
);

const TextStyle kNegativeChange = TextStyle(
  color: kNegativeColor,
  fontSize: 16,
  fontWeight: FontWeight.w800
);
