import 'package:stock_learner/core/models/markets/market_active/market_active.dart';

class MarketMoversModelData {
  final List<MarketActiveModel> marketActiveModelData;

  MarketMoversModelData({
    required this.marketActiveModelData
  });

  static List<MarketActiveModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketActiveModel.fromJson(item))
    .toList();
  }
}
