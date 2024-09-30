class MarketActiveModel {
  final String ticker;
  final double changes;
  final String price;
  final String changesPercentage;
  final String companyName;

  MarketActiveModel({
    required this.ticker,
    required this.changes,
    required this.price,
    required this.changesPercentage,
    required this.companyName
  });

  factory MarketActiveModel.fromJson(Map<String, dynamic> json) {
    return MarketActiveModel(
      ticker: json['ticker'],
      changes: json['changes'],
      price: json['price'],
      changesPercentage: json['changesPercentage'],
      companyName: json['companyName'],
    );
  }
}
