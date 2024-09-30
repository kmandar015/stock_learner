import 'package:flutter/material.dart';
import 'package:stock_learner/core/shared/colors.dart';



/// This is the common border radious of all the containers in the app.
const kStandatBorder = BorderRadius.all(Radius.circular(6));

/// This border is slightly more sharp than the standard boder.
const kSharpBorder = BorderRadius.all(Radius.circular(2));

/// This is the common text styling for a subtile. 
const kSubtitleStyling = TextStyle(
  color: kGray,
  fontSize: 24,
  fontWeight: FontWeight.w800
);

/// This is the common text styling for a subtile. 
const kCompanyNameHeading = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w800
);