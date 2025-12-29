import '../config/app_config.dart';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // ================= GET ALL PRODUCTS =================
  Future<Map<String, dynamic>> getAllProducts() async {
    try {
      final response = await _apiService.get(
        AppConfig.produk,
        needsAuth: false,
      );

      final data = _apiService.parseResponse(response);

      final bool isOk = response.statusCode >= 200 && response.statusCode < 300;
      final dynamic statusRaw = data['status'];
      final String? status = statusRaw is String
          ? statusRaw.toLowerCase()
          : null;
      final bool statusOk =
          status == null ||
          status == 'success' ||
          status == 'berhasil' ||
          status == 'ok' ||
          status == 'true';

      if (isOk && statusOk && data.containsKey('data')) {
        // Parse list of products
        final List<dynamic> productsJson = data['data'] ?? [];
        final List<ProductModel> products = productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return {'success': true, 'products': products};
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to fetch products',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= GET PRODUCTS BY CATEGORY =================
  Future<Map<String, dynamic>> getProductsByCategory(String kategori) async {
    try {
      final response = await _apiService.get(
        AppConfig.getProdukByKategori(kategori),
        needsAuth: false,
      );

      final data = _apiService.parseResponse(response);

      final bool isOk = response.statusCode >= 200 && response.statusCode < 300;
      final dynamic statusRaw = data['status'];
      final String? status = statusRaw is String
          ? statusRaw.toLowerCase()
          : null;
      final bool statusOk =
          status == null ||
          status == 'success' ||
          status == 'berhasil' ||
          status == 'ok' ||
          status == 'true';

      if (isOk && statusOk && data.containsKey('data')) {
        // Parse list of products
        final List<dynamic> productsJson = data['data'] ?? [];
        final List<ProductModel> products = productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return {'success': true, 'products': products};
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to fetch products by category',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= GET PRODUCT BY ID =================
  Future<Map<String, dynamic>> getProductById(int id) async {
    try {
      final response = await _apiService.get(
        AppConfig.getProdukById(id),
        needsAuth: false,
      );

      final data = _apiService.parseResponse(response);

      final bool isOk = response.statusCode >= 200 && response.statusCode < 300;
      final dynamic statusRaw = data['status'];
      final String? status = statusRaw is String
          ? statusRaw.toLowerCase()
          : null;
      final bool statusOk =
          status == null ||
          status == 'success' ||
          status == 'berhasil' ||
          status == 'ok' ||
          status == 'true';

      if (isOk && statusOk && data.containsKey('data')) {
        final product = ProductModel.fromJson(data['data']);
        return {'success': true, 'product': product};
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Failed to fetch product',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= GET ALL CATEGORIES =================
  Future<Map<String, dynamic>> getAllCategories() async {
    try {
      print('🌐 [ProductService] Fetching from: ${AppConfig.baseUrl}${AppConfig.produkKategori}');
      final response = await _apiService.get(
        AppConfig.produkKategori,
        needsAuth: false,
      );

      print('📡 [ProductService] Status code: ${response.statusCode}');
      print('📡 [ProductService] Response body: ${response.body}');
      
      final data = _apiService.parseResponse(response);
      print('📊 [ProductService] Parsed data: $data');
      print('📊 [ProductService] Success field: ${data['success']}');
      print('📊 [ProductService] Data field: ${data['data']}');

      // Backend returns "success": true (boolean), not "status": "success" (string)
      if (response.statusCode == 200 && data['success'] == true) {
        // Parse list of categories
        final List<dynamic> categoriesJson = data['data'] ?? [];
        final List<String> categories = categoriesJson
            .map((item) => item.toString())
            .toList();

        print('✅ [ProductService] Categories parsed: $categories');
        return {'success': true, 'kategori': categories};
      }

      print('⚠️ [ProductService] Condition failed - statusCode: ${response.statusCode}, success: ${data['success']}');
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to fetch categories',
      };
    } catch (e) {
      print('❌ [ProductService] Exception: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ================= GET FEATURED PRODUCTS (LIMIT) =================
  // Untuk menampilkan beberapa produk di main page
  Future<Map<String, dynamic>> getFeaturedProducts({int limit = 10}) async {
    try {
      // Menggunakan endpoint yang sama dengan getAllProducts
      // Tapi kita akan limit di client side
      final result = await getAllProducts();

      if (result['success'] == true) {
        final List<ProductModel> allProducts = result['products'];
        final List<ProductModel> featured = allProducts.take(limit).toList();

        return {'success': true, 'products': featured};
      }

      return result;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
