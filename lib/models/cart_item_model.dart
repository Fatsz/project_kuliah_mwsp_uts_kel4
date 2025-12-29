import 'package:project_kuliah_mwsp_uts_kel4/models/product_model.dart';

class CartItemModel {
  final String id;
  final int? backendCartId; // ID from backend keranjang table
  final ProductModel product;
  final int quantity;
  final String size;
  final String status; // 'all', 'delivery', 'done'

  CartItemModel({
    required this.id,
    this.backendCartId,
    required this.product,
    required this.quantity,
    required this.size,
    this.status = 'all', // Default status is 'all'
  });

  // Calculate total price for this cart item
  double get totalPrice => product.harga.toDouble() * quantity;

  // Create a copy with updated fields
  CartItemModel copyWith({
    String? id,
    int? backendCartId,
    ProductModel? product,
    int? quantity,
    String? size,
    String? status,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      backendCartId: backendCartId ?? this.backendCartId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      status: status ?? this.status,
    );
  }
}
