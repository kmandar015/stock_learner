import 'package:flutter/material.dart';
import 'package:stock_learner/core/shared/colors.dart';

class EmptyScreen extends StatelessWidget {
  final String message;

  EmptyScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
          height: 1.5, fontSize: 20, fontWeight: FontWeight.bold, color: kGray),
      textAlign: TextAlign.start,
    );
  }
}
