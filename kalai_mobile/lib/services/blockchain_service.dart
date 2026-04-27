import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:kalai_mobile/models/product_model.dart';

class BlockchainService {
	Future<String> registerProduct(Product product) async {
		final payload = jsonEncode(product.toJson());
		return sha256.convert(utf8.encode(payload)).toString();
	}
}
