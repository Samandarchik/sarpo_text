


class FactoryGetAllResponse {
  final int count;
  final List<Factory> factories;

  FactoryGetAllResponse({
    required this.count,
    required this.factories,
  });

  factory FactoryGetAllResponse.fromJson(Map<String, dynamic> json) {
    return FactoryGetAllResponse(
      count: json['count'] ?? 0,
      factories: (json['factorys'] as List<dynamic>?)
          ?.map((e) => Factory.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'factorys': factories.map((e) => e.toJson()).toList(),
    };
  }
}


class Factory {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final String createdAt;

  Factory({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.createdAt,
  });

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'created_at': createdAt,
    };
  }
}


