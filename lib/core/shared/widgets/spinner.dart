import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  
  final Color color;

  const SpinnerWidget({super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(this.color),
      )
    );
  }
}
