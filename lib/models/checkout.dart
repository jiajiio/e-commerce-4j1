class Checkout {
  // final String customerId;
  // final String nama;
  // final String alamat;
  // final String kodePos;
  // final String noTelpon;
  // final String ongkir;
  // final String pajak;
  // final String transaksiTotal;
  // final String transaksiStatus;
  // final String uuid;
  // final String tags;
  // final int adminId;
  // final String updatedAt;
  // final String createdAt;
  // final int id;
  final String paymentUrl;

  Checkout({
    // required this.customerId,
    // required this.nama,
    // required this.alamat,
    // required this.kodePos,
    // required this.noTelpon,
    // required this.ongkir,
    // required this.pajak,
    // required this.transaksiTotal,
    // required this.transaksiStatus,
    // required this.uuid,
    // required this.tags,
    // required this.adminId,
    // required this.updatedAt,
    // required this.createdAt,
    // required this.id,
    required this.paymentUrl,
  });

  Checkout copyWith({
    String? customerId,
    String? nama,
    String? alamat,
    String? kodePos,
    String? noTelpon,
    String? ongkir,
    String? pajak,
    String? transaksiTotal,
    String? transaksiStatus,
    String? uuid,
    String? tags,
    int? adminId,
    String? updatedAt,
    String? createdAt,
    int? id,
    String? paymentUrl,
  }) =>
      Checkout(
        // customerId: customerId ?? this.customerId,
        // nama: nama ?? this.nama,
        // alamat: alamat ?? this.alamat,
        // kodePos: kodePos ?? this.kodePos,
        // noTelpon: noTelpon ?? this.noTelpon,
        // ongkir: ongkir ?? this.ongkir,
        // pajak: pajak ?? this.pajak,
        // transaksiTotal: transaksiTotal ?? this.transaksiTotal,
        // transaksiStatus: transaksiStatus ?? this.transaksiStatus,
        // uuid: uuid ?? this.uuid,
        // tags: tags ?? this.tags,
        // adminId: adminId ?? this.adminId,
        // updatedAt: updatedAt ?? this.updatedAt,
        // createdAt: createdAt ?? this.createdAt,
        // id: id ?? this.id,
        paymentUrl: paymentUrl ?? this.paymentUrl,
      );

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        // customerId: json["customer_id"],
        // nama: json["nama"],
        // alamat: json["alamat"],
        // kodePos: json["kode_pos"],
        // noTelpon: json["no_telpon"],
        // ongkir: json["ongkir"],
        // pajak: json["pajak"],
        // transaksiTotal: json["transaksi_total"],
        // transaksiStatus: json["transaksi_status"],
        // uuid: json["uuid"],
        // tags: json["tags"],
        // adminId: json["admin_id"],
        // updatedAt: json["updated_at"],
        // createdAt: json["created_at"],
        // id: json["id"],
        paymentUrl: json["paymentUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "customer_id": customerId,
        // "nama": nama,
        // "alamat": alamat,
        // "kode_pos": kodePos,
        // "no_telpon": noTelpon,
        // "ongkir": ongkir,
        // "pajak": pajak,
        // "transaksi_total": transaksiTotal,
        // "transaksi_status": transaksiStatus,
        // "uuid": uuid,
        // "tags": tags,
        // "admin_id": adminId,
        // "updated_at": updatedAt,
        // "created_at": createdAt,
        // "id": id,
        "paymentUrl": paymentUrl,
      };
}
