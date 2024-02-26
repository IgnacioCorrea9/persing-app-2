class PaymentData {
  final String userId;
  final LocationData data;

  final String reference;
  final int pago;

  final List<String> productos;
  PaymentData({
    required this.userId,
    required this.data,
    required this.reference,
    required this.pago,
    required this.productos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario': userId,
      'location': data.toMap(),
      'reference': reference,
      'pago': pago,
      'productos': productos,
    };
  }

  factory PaymentData.fromMap(Map<String, dynamic> map) {
    return PaymentData(
      userId: map['userId']?.toString() ?? '',
      data: LocationData.fromMap((map['data'] ?? {}) as Map<String, dynamic>),
      reference: map['reference']?.toString() ?? '',
      pago: (map['pago'] as int) ?? 0,
      productos: List.from(
        ((map['productos'] ?? []) as List<String>),
      ),
    );
  }
}

class LocationData {
  LocationData({
    this.country = '',
    this.city = '',
    this.address = '',
  });
  final String country;
  final String city;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'city': city,
      'address': address,
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      country: map['country']?.toString() ?? '',
      city: map['city']?.toString() ?? '',
      address: map['address']?.toString() ?? '',
    );
  }
}
