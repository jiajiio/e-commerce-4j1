class User {
  final int id;
  final String nama;
  final String alamat;
  final String provinsi;
  final String kota;
  final String kodePos;
  final String email;
  final String noTelp;
  final String apiToken;
  final String provIndex;
  final String admin;

  User({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.provinsi,
    required this.kota,
    required this.kodePos,
    required this.email,
    required this.noTelp,
    required this.apiToken,
    required this.provIndex,
    required this.admin,
  });

  User copyWith({
    int? id,
    String? nama,
    String? alamat,
    String? provinsi,
    String? kota,
    String? kodePos,
    String? email,
    String? noTelp,
    String? apiToken,
    String? provIndex,
    String? admin,
  }) =>
      User(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        alamat: alamat ?? this.alamat,
        provinsi: provinsi ?? this.provinsi,
        kota: kota ?? this.kota,
        kodePos: kodePos ?? this.kodePos,
        email: email ?? this.email,
        noTelp: noTelp ?? this.noTelp,
        apiToken: apiToken ?? this.apiToken,
        provIndex: provIndex ?? this.provIndex,
        admin: admin ?? this.admin,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["Nama"],
        alamat: json["alamat"],
        provinsi: json["provinsi"],
        kota: json["kota"],
        kodePos: json["kode_pos"],
        email: json["email"],
        noTelp: json["no_telp"],
        apiToken: json["api_token"],
        provIndex: json["prov_index"],
        admin: json["admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Nama": nama,
        "alamat": alamat,
        "provinsi": provinsi,
        "kota": kota,
        "kode_pos": kodePos,
        "email": email,
        "no_telp": noTelp,
        "api_token": apiToken,
        "prov_index": provIndex,
        "admin": admin,
      };
}

User userDummy = User(
  id: 0,
  nama: '',
  alamat: '',
  provinsi: '',
  kota: '',
  kodePos: '',
  email: '',
  noTelp: '',
  apiToken: '',
  provIndex: '',
  admin: '0',
);
