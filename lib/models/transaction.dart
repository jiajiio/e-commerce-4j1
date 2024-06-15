class Transaction {
  final int id;
  final String uuid;
  final String customerId;
  final String nama;
  final String noTelpon;
  final String alamat;
  final String kodePos;
  final String adminId;
  final String ongkir;
  final String pajak;
  final String transaksiTotal;
  final String transaksiStatus;
  final String tags;
  final String resiKirim;
  final String createdAt;
  final String updatedAt;
  final String tanggal;

  Transaction({
    required this.id,
    required this.uuid,
    required this.customerId,
    required this.nama,
    required this.noTelpon,
    required this.alamat,
    required this.kodePos,
    required this.adminId,
    required this.ongkir,
    required this.pajak,
    required this.transaksiTotal,
    required this.transaksiStatus,
    required this.tags,
    required this.resiKirim,
    required this.createdAt,
    required this.updatedAt,
    required this.tanggal,
  });
  Transaction copyWith({
    int? id,
    String? uuid,
    String? customerId,
    String? nama,
    String? noTelpon,
    String? alamat,
    String? kodePos,
    String? adminId,
    String? ongkir,
    String? pajak,
    String? transaksiTotal,
    String? transaksiStatus,
    String? tags,
    String? resiKirim,
    String? createdAt,
    String? updatedAt,
    String? tanggal,
  }) =>
      Transaction(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        customerId: customerId ?? this.customerId,
        nama: nama ?? this.nama,
        noTelpon: noTelpon ?? this.noTelpon,
        alamat: alamat ?? this.alamat,
        kodePos: kodePos ?? this.kodePos,
        adminId: adminId ?? this.adminId,
        ongkir: ongkir ?? this.ongkir,
        pajak: pajak ?? this.pajak,
        transaksiTotal: transaksiTotal ?? this.transaksiTotal,
        transaksiStatus: transaksiStatus ?? this.transaksiStatus,
        tags: tags ?? this.tags,
        resiKirim: resiKirim ?? this.resiKirim,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tanggal: tanggal ?? this.tanggal,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        uuid: json["uuid"],
        customerId: json["customer_id"],
        nama: json["nama"],
        noTelpon: json["no_telpon"],
        alamat: json["alamat"],
        kodePos: json["kode_pos"],
        adminId: json["admin_id"],
        ongkir: json["ongkir"],
        pajak: json["pajak"],
        transaksiTotal: json["transaksi_total"],
        transaksiStatus: json["transaksi_status"],
        tags: json["tags"],
        resiKirim: json["resi_kirim"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        tanggal: json["tanggal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "customer_id": customerId,
        "nama": nama,
        "no_telpon": noTelpon,
        "alamat": alamat,
        "kode_pos": kodePos,
        "admin_id": adminId,
        "ongkir": ongkir,
        "pajak": pajak,
        "transaksi_total": transaksiTotal,
        "transaksi_status": transaksiStatus,
        "tags": tags,
        "resi_kirim": resiKirim,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "tanggal": tanggal,
      };
}
