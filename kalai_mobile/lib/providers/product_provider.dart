import 'package:flutter/material.dart';
import 'package:kalai_mobile/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  bool _isLoading = false;

  List<dynamic> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchRealTimeProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await ApiService.fetchProducts();
    } catch (e) {
      print("Failed to fetch $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addRealtimeProduct(Map<String, dynamic> product, String token) async {
    try {
      final newProduct = await ApiService.addProduct(product, token);
      _products.add(newProduct['product']); // Inject into current view instantly
      notifyListeners();
    } catch (e) {
      print("Adding failed $e");
      rethrow;
    }
  }
}
