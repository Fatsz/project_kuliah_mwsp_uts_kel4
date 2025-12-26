// Gunakan 10.0.2.2 untuk Android emulator (localhost di komputer host)
// Untuk perangkat fisik, ganti dengan IP address komputer (misal: http://192.168.1.5:4000)
// Untuk iOS simulator, gunakan http://localhost:4000

class ApiUrl {
  /// Base URL untuk endpoint backend (tanpa path resource).
  static const String base = 'http://192.168.1.100:4000';

  /// Endpoint resource users.
  static const String users = '$base/users';

  /// Endpoint resource products.
  static const String products = '$base/products';
}
