class CostPrice {
  final String code;
  final String name;
  final List<CostPriceCost> costs;
  bool selected;

  CostPrice({
    required this.code,
    required this.name,
    required this.costs,
    this.selected = false,
  });

  CostPrice copyWith({
    String? code,
    String? name,
    List<CostPriceCost>? costs,
  }) =>
      CostPrice(
        code: code ?? this.code,
        name: name ?? this.name,
        costs: costs ?? this.costs,
      );

  factory CostPrice.fromJson(Map<String, dynamic> json) => CostPrice(
        code: json["code"],
        name: json["name"],
        costs: List<CostPriceCost>.from(
            json["costs"].map((x) => CostPriceCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
}

class CostPriceCost {
  final String service;
  final String description;
  final List<CostCost> cost;

  CostPriceCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  CostPriceCost copyWith({
    String? service,
    String? description,
    List<CostCost>? cost,
  }) =>
      CostPriceCost(
        service: service ?? this.service,
        description: description ?? this.description,
        cost: cost ?? this.cost,
      );

  factory CostPriceCost.fromJson(Map<String, dynamic> json) => CostPriceCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class CostCost {
  final int value;
  final String etd;
  final String note;

  CostCost({
    required this.value,
    required this.etd,
    required this.note,
  });

  CostCost copyWith({
    int? value,
    String? etd,
    String? note,
  }) =>
      CostCost(
        value: value ?? this.value,
        etd: etd ?? this.etd,
        note: note ?? this.note,
      );

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
