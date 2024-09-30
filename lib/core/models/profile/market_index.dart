class MarketIndexModel {
  final String symbol;
  final double change;
  final double price;
  final String name;

  MarketIndexModel({
    required this.symbol,
    required this.change,
    required this.price,
    required this.name
  });

  static List<MarketIndexModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketIndexModel.fromJson(item))
    .toList();
  }

  factory MarketIndexModel.fromJson(Map<String, dynamic> json) {
    return MarketIndexModel(
      symbol: json['symbol'],
      change: json['change'],
      price: json['price'],
      name: json['name'],
    );
  }
}