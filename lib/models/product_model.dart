class ProductModel {
  final int idProduk;
  final String nama;
  final String? gambarUrl;
  final String kategori;
  final int harga;
  final String? deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.idProduk,
    required this.nama,
    this.gambarUrl,
    required this.kategori,
    required this.harga,
    this.deskripsi,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProduk: json['id_produk'] ?? 0,
      nama: json['nama'] ?? '',
      gambarUrl: json['gambar_url'],
      kategori: json['kategori'] ?? '',
      harga: json['harga'] ?? 0,
      deskripsi: json['deskripsi'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'nama': nama,
      'gambar_url': gambarUrl,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': deskripsi,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProductModel copyWith({
    int? idProduk,
    String? nama,
    String? gambarUrl,
    String? kategori,
    int? harga,
    String? deskripsi,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      idProduk: idProduk ?? this.idProduk,
      nama: nama ?? this.nama,
      gambarUrl: gambarUrl ?? this.gambarUrl,
      kategori: kategori ?? this.kategori,
      harga: harga ?? this.harga,
      deskripsi: deskripsi ?? this.deskripsi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
