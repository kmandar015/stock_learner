import 'package:stock_learner/core/models/profile/stock_chart.dart';
import 'package:stock_learner/core/models/profile/stock_profile.dart';
import 'package:stock_learner/core/models/profile/stock_quote.dart';

class ProfileModel {

  final StockProfile stockProfile;
  final StockQuote stockQuote;
  final List<StockChart> stockChart;

  ProfileModel({
    required this.stockProfile,
    required this.stockQuote,
    required this.stockChart,
  });
}
