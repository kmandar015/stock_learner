import 'package:flutter/material.dart';

class StandardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget action;

  const StandardHeader(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.action});

  static const kPortfolioHeaderTitle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static const kPortfolioSubtitle = TextStyle(
      color: Colors.white54, fontSize: 24, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Text(title, style: kPortfolioHeaderTitle),
            ),
            action
          ],
        ),
        Text(subtitle, style: kPortfolioSubtitle),
      ],
    );
  }
}
