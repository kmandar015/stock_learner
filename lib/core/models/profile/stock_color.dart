class StockChangeColor {
  final double changesPercentage;

  StockChangeColor({
    required this.changesPercentage,
  });

  factory StockChangeColor.fromJson(Map<String, dynamic> json) {
    return StockChangeColor(
      changesPercentage: json['changesPercentage'],
    );
  }


}