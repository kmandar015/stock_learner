class StockQuote {
  final String symbol;
  final String name;

  final double price;
  final double changesPercentage;
  final double change;
  final double dayLow;
  final double dayHigh;
  final double yearHigh;
  final double yearLow;
  final double marketCap;

  final int volume;
  final int avgVolume;

  final double open;
  final double previousClose;
  final double eps;
  final double pe;
  
  final int sharesOutstanding;

  StockQuote({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changesPercentage,
    required this.change,
    required this.dayLow,
    required this.dayHigh,
    required this.yearHigh,
    required this.yearLow,
    required this.marketCap,
    required this.volume,
    required this.avgVolume,
    required this.open,
    required this.previousClose,
    required this.eps,
    required this.pe,
    required this.sharesOutstanding,
  });

  factory StockQuote.fromJson(Map<String, dynamic> json) {
    return StockQuote(
      symbol: json['symbol'],
      name: json['name'],
      price: json['price'],
      changesPercentage: json['changesPercentage'],
      change: json['change'],
      dayLow: json['dayLow'],
      dayHigh: json['dayHigh'],
      yearHigh: json['yearHigh'],
      yearLow: json['yearLow'],
      marketCap: json['marketCap'],
      volume: json['volume'],
      avgVolume: json['avgVolume'],
      open: json['open'],
      previousClose: json['previousClose'],
      eps: json['eps'],
      pe: json['pe'],
      sharesOutstanding: json['sharesOutstanding'],
    );
  }

}