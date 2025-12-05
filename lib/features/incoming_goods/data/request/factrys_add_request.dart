
class FactriysAddRequest {
  final String address;
  final String name;
  final String phoneNumber;

  FactriysAddRequest({
    required this.address,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'phone_number': phoneNumber,
    };
  }

  factory FactriysAddRequest.fromJson(Map<String, dynamic> json) {
    return FactriysAddRequest(
      address: json['address'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
    );
  }
}