class Achievement {
  late String award;
  late String issuer;
  late String year;
  late String description;

  Achievement({
    required this.award,
    required this.issuer,
    required this.year,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "award": award,
    "issuer": issuer,
    "year": year,
    "description": description,
  };
}
