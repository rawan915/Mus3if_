class Hospital {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? phone;
  final String? alternatePhone;
  final String? specialty;
  final double? distance;

  Hospital({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.phone,
    this.alternatePhone,
    this.specialty,
    this.distance,
  });

  Hospital copyWith({double? distance}) {
    return Hospital(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      phone: phone,
      alternatePhone: alternatePhone,
      specialty: specialty,
      distance: distance ?? this.distance,
    );
  }
}
