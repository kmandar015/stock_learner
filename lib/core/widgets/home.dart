import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stock_learner/core/widgets/markets/markets_section.dart';
import 'package:stock_learner/core/widgets/news/news_section.dart';
import 'package:stock_learner/core/widgets/portfolio/portfolio.dart';
import 'package:stock_learner/core/widgets/search/search_section.dart';

class StockMarketAppHome extends StatefulWidget {
  const StockMarketAppHome({super.key});

  @override
  _StockMarketAppHomeState createState() => _StockMarketAppHomeState();
}

class _StockMarketAppHomeState extends State<StockMarketAppHome> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    const PortfolioSection(),
    MarketsSection(),
    SearchSection(),
    const NewsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: tabs.elementAt(_selectedIndex),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: const Duration(milliseconds: 800),
                tabBackgroundColor: Colors.white30,
                selectedIndex: _selectedIndex,
                tabs: _bottomNavigationBarItemItems(),
                onTabChange: _onItemTapped),
          ),
        ));
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      const GButton(
        icon: FontAwesomeIcons.shapes,
        text: 'Home',
      ),
      const GButton(
        icon: FontAwesomeIcons.suitcase,
        text: 'Markets',
      ),
      const GButton(
        icon: FontAwesomeIcons.magnifyingGlass,
        text: 'Search',
      ),
      const GButton(
        icon: FontAwesomeIcons.earthAmericas,
        text: 'News',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
