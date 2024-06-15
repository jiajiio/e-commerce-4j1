class Province {
  final String provinceId;
  final String province;

  Province({
    required this.provinceId,
    required this.province,
  });

  Province copyWith({
    String? provinceId,
    String? province,
  }) =>
      Province(
        provinceId: provinceId ?? this.provinceId,
        province: province ?? this.province,
      );

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };
}
