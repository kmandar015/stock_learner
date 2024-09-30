class StockProfile {
  final double price;
  final String beta;
  final String volAvg;
  final String mktCap;
  final double changes;
  final String changesPercentage;
  final String companyName;
  final String exchange;
  final String industry;
  final String description;
  final String ceo;
  final String sector;

  StockProfile({
    required this.price,
    required this.beta,
    required this.volAvg,
    required this.mktCap,
    required this.changes,
    required this.changesPercentage,
    required this.companyName,
    required this.exchange,
    required this.industry,
    required this.description,
    required this.ceo,
    required this.sector,
  });

  factory StockProfile.fromJson(Map<String, dynamic> json) {
    return StockProfile(
      price: json['price'],
      beta: json['beta'],
      volAvg: json['volAvg'],
      mktCap: json['mktCap'],
      changes: json['changes'],
      changesPercentage: json['changesPercentage'],
      companyName: json['companyName'],
      exchange: json['exchange'],
      industry: json['industry'],
      description: json['description'],
      ceo: json['ceo'],
      sector: json['sector'],
    );
  }

}
