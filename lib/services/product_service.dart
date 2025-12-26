import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_kuliah_mwsp_uts_kel4/api/api_url.dart';
import 'package:project_kuliah_mwsp_uts_kel4/models/product.dart';

class ProductService {

  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse(ApiUrl.products));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat produk: ${res.statusCode}');
    }
    final decoded = jsonDecode(res.body);

    // Handle response with "data" field
    if (decoded is Map && decoded['data'] is List) {
      return (decoded['data'] as List)
          .map<Product>((e) => Product.fromJson(e))
          .toList();
    }
    // Handle direct array response
    if (decoded is List) {
      return decoded.map<Product>((e) => Product.fromJson(e)).toList();
    }
    // Handle response with "products" field
    if (decoded is Map && decoded['products'] is List) {
      return (decoded['products'] as List)
          .map<Product>((e) => Product.fromJson(e))
          .toList();
    }
    throw Exception('Format respons produk tidak sesuai');
  }
}
