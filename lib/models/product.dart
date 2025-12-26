class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Map backend fields (dengan underscore)
    final dynamic idVal = json['id_product'] ?? json['id'] ?? json['_id'] ?? '';
    final String nameVal =
        (json['nama_product'] ??
                json['name'] ??
                json['title'] ??
                'Unnamed Product')
            .toString();
    final String descVal =
        (json['deskripsi_product'] ?? json['description'] ?? json['desc'] ?? '')
            .toString();
    final String categoryVal =
        (json['kategori_product'] ??
                json['category'] ??
                json['type'] ??
                'Beverages')
            .toString();

    // price can be int or double or string
    double parsePrice(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    final double priceVal = parsePrice(
      json['harga_product'] ?? json['price'] ?? json['amount'],
    );

    // image - backend uses image_product
    String imageVal = '';
    if (json['image_product'] != null &&
        json['image_product'].toString().isNotEmpty) {
      imageVal = json['image_product'].toString();
    } else if (json['image'] != null) {
      imageVal = json['image'].toString();
    } else if (json['imageUrl'] != null) {
      imageVal = json['imageUrl'].toString();
    }

    return Product(
      id: idVal.toString(),
      name: nameVal,
      description: descVal,
      category: categoryVal,
      price: priceVal,
      imageUrl: imageVal,
    );
  }
}
