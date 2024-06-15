import 'dart:convert';
import 'package:intl/intl.dart';

class Toys {
  final int id;
  final String kode;
  final String nama;
  final String slug;
  final String harga;
  final String berat;
  final String deskripsi;
  final String createdAt;
  final String updatedAt;
  final List<Gallery> gallery;
  // final Produk jenisProduk;
  // final Produk satuanProduk;
  // final Produk brandProduk;
  // final List<dynamic> getDiskon;
  int amount;

  Toys({
    required this.id,
    required this.kode,
    required this.nama,
    required this.slug,
    required this.harga,
    required this.berat,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
    required this.gallery,
    // required this.jenisProduk,
    // required this.satuanProduk,
    // required this.brandProduk,
    // required this.getDiskon,
    this.amount = 0,
  });

  Toys copyWith({
    int? id,
    String? kode,
    String? nama,
    String? slug,
    String? jenisId,
    String? harga,
    String? stok,
    String? berat,
    String? satuan,
    String? deskripsi,
    String? brand,
    String? createdAt,
    String? updatedAt,
    List<Gallery>? gallery,
    Produk? jenisProduk,
    Produk? satuanProduk,
    Produk? brandProduk,
    List<dynamic>? getDiskon,
    int? amount,
  }) =>
      Toys(
        id: id ?? this.id,
        kode: kode ?? this.kode,
        nama: nama ?? this.nama,
        slug: slug ?? this.slug,
        harga: harga ?? this.harga,
        berat: berat ?? this.berat,
        deskripsi: deskripsi ?? this.deskripsi,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        gallery: gallery ?? this.gallery,
        // jenisProduk: jenisProduk ?? this.jenisProduk,
        // satuanProduk: satuanProduk ?? this.satuanProduk,
        // brandProduk: brandProduk ?? this.brandProduk,
        // getDiskon: getDiskon ?? this.getDiskon,
        amount: amount ?? this.amount,
      );

  factory Toys.fromJson(Map<String, dynamic> json) => Toys(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        slug: json["slug"],
        harga: json["harga"],
        berat: json["berat"],
        deskripsi: json["deskripsi"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        // jenisProduk: Produk.fromJson(json["jenis_produk"]),
        // satuanProduk: Produk.fromJson(json["satuan_produk"]),
        // brandProduk: Produk.fromJson(json["brand_produk"]),
        // getDiskon: List<dynamic>.from(json["get_diskon"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "slug": slug,
        "harga": harga,
        "berat": berat,
        "deskripsi": deskripsi,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        // "jenis_produk": jenisProduk.toJson(),
        // "satuan_produk": satuanProduk.toJson(),
        // "brand_produk": brandProduk.toJson(),
        // "get_diskon": List<dynamic>.from(getDiskon.map((x) => x)),
      };

  String get hargaFormatted =>
      NumberFormat.currency(locale: 'ID', decimalDigits: 0, symbol: 'Rp.')
          .format(int.parse(harga));
}

class Produk {
  final int id;
  final String nama;
  final String createdAt;
  final String updatedAt;

  Produk({
    required this.id,
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  Produk copyWith({
    int? id,
    String? nama,
    String? createdAt,
    String? updatedAt,
  }) =>
      Produk(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        nama: json["nama"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Gallery {
  final int id;
  final String productId;
  final String photoUrl;
  final String createdAt;
  final String updatedAt;

  Gallery({
    required this.id,
    required this.productId,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Gallery copyWith({
    int? id,
    String? productId,
    String? photoUrl,
    String? createdAt,
    String? updatedAt,
  }) =>
      Gallery(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        photoUrl: photoUrl ?? this.photoUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Gallery.fromRawJson(String str) => Gallery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        productId: json["product_id"],
        photoUrl: json["photo_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "photo_url": photoUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
