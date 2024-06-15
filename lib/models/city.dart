class City {
  final String cityId;
  final String provinceId;
  final String province;
  final String type;
  final String cityName;
  final String postalCode;

  City({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  City copyWith({
    String? cityId,
    String? provinceId,
    String? province,
    String? type,
    String? cityName,
    String? postalCode,
  }) =>
      City(
        cityId: cityId ?? this.cityId,
        provinceId: provinceId ?? this.provinceId,
        province: province ?? this.province,
        type: type ?? this.type,
        cityName: cityName ?? this.cityName,
        postalCode: postalCode ?? this.postalCode,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}
