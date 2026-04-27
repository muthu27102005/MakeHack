class Product {
	final String id;
	final String name;
	final String category;
	final List<String> materials;
	final String description;
	final String gpsLocation;
	final String artisanId;
	final String status;
	final String? blockchainHash;

	const Product({
		required this.id,
		required this.name,
		required this.category,
		required this.materials,
		required this.description,
		required this.gpsLocation,
		required this.artisanId,
		required this.status,
		this.blockchainHash,
	});

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'category': category,
				'materials': materials,
				'description': description,
				'gpsLocation': gpsLocation,
				'artisanId': artisanId,
				'status': status,
				'blockchainHash': blockchainHash,
			};

	factory Product.fromJson(Map<String, dynamic> json) {
		return Product(
			id: json['id']?.toString() ?? '',
			name: json['name']?.toString() ?? '',
			category: json['category']?.toString() ?? '',
			materials: (json['materials'] as List<dynamic>? ?? []).map((value) => value.toString()).toList(),
			description: json['description']?.toString() ?? '',
			gpsLocation: json['gpsLocation']?.toString() ?? '',
			artisanId: json['artisanId']?.toString() ?? '',
			status: json['status']?.toString() ?? 'pending',
			blockchainHash: json['blockchainHash']?.toString(),
		);
	}

	Product copyWith({String? blockchainHash, String? status}) {
		return Product(
			id: id,
			name: name,
			category: category,
			materials: materials,
			description: description,
			gpsLocation: gpsLocation,
			artisanId: artisanId,
			status: status ?? this.status,
			blockchainHash: blockchainHash ?? this.blockchainHash,
		);
	}
}
