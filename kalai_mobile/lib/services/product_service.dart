import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kalai_mobile/models/product_model.dart';
import 'package:kalai_mobile/utils/constants.dart';

class ProductService {
	final ValueNotifier<List<Product>> products = ValueNotifier<List<Product>>(<Product>[]);

	Uri? get _productsUri {
		if (KalaiAppConfig.apiBaseUrl.isEmpty) {
			return null;
		}
		return Uri.parse('${KalaiAppConfig.apiBaseUrl}/api/products');
	}

	Future<void> loadProducts() async {
		final uri = _productsUri;
		if (uri == null) return;

		try {
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				final decoded = jsonDecode(response.body) as List<dynamic>;
				products.value = decoded.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
			}
		} catch (_) {
			// Offline fallback keeps the demo usable if backend is not running.
		}
	}

	Future<Product> addProduct(Product product) async {
		final uri = _productsUri;
		if (uri != null) {
			try {
				final response = await http.post(
					uri,
					headers: const {'Content-Type': 'application/json'},
					body: jsonEncode(product.toJson()),
				);

				if (response.statusCode == 201) {
					final created = Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
					products.value = [created, ...products.value.where((item) => item.id != created.id)];
					return created;
				}
			} catch (_) {
				// Fall through to local demo mode.
			}
		}

		final updated = List<Product>.from(products.value)..insert(0, product);
		products.value = updated;
		return product;
	}

	Future<void> updateBlockchainHash(String productId, String blockchainHash) async {
		final uri = _productsUri;
		if (uri != null) {
			try {
				await http.patch(
					Uri.parse('${uri.toString()}/$productId/hash'),
					headers: const {'Content-Type': 'application/json'},
					body: jsonEncode({'blockchainHash': blockchainHash, 'status': 'verified'}),
				);
			} catch (_) {
				// Ignore network errors and keep the local demo state updated.
			}
		}

		final updated = products.value.map((product) {
			if (product.id == productId) {
				return product.copyWith(blockchainHash: blockchainHash, status: 'verified');
			}
			return product;
		}).toList();
		products.value = updated;
	}
}
