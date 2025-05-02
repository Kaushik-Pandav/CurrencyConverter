class Currency {
  Currency({
    required this.timestamp,
    required this.base,
    required this.success,
    required this.date,
    required this.rates,
  });

  final int? timestamp;
  final String? base;
  final bool? success;
  final DateTime? date;
  final Map<String, dynamic> rates;

  factory Currency.fromJson(Map<String, dynamic> json){
    return Currency(
      timestamp: json["timestamp"],
      base: json["base"],
      success: json["success"],
      date: DateTime.tryParse(json["date"] ?? ""),
      rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
    );
  }

}
