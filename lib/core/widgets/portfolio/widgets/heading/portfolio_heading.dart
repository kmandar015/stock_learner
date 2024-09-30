import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stock_learner/core/widgets/widgets/standard/header.dart';
class PortfolioHeadingSection extends StatelessWidget {
  const PortfolioHeadingSection({super.key});

  @override
  Widget build(BuildContext context) {

    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());

    return StandardHeader(
      title: 'Portfolio',
      subtitle: formattedDate,
      action: GestureDetector(
        child: Icon(FontAwesomeIcons.user),
        onTap: () => Navigator.pushNamed(context, '/about')
      ),
    );
  }
}