class EmergencyContact {
  final String name;
  final String phoneNumber;
  final String? alternatePhone;
  final String? relationship;
  final String? specialty;
  final String? location;
  final String? schedule;
  final String type;
  final String? scheduleUrl;
  final String? studentScheduleUrl;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    this.alternatePhone,
    this.relationship,
    this.specialty,
    this.location,
    this.schedule,
    required this.type,
    this.scheduleUrl,
    this.studentScheduleUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'alternatePhone': alternatePhone,
      'relationship': relationship,
      'specialty': specialty,
      'location': location,
      'schedule': schedule,
      'type': type,
      'scheduleUrl': scheduleUrl,
      'studentScheduleUrl': studentScheduleUrl,
    };
  }

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      alternatePhone: json['alternatePhone'],
      relationship: json['relationship'],
      specialty: json['specialty'],
      location: json['location'],
      schedule: json['schedule'],
      type: json['type'],
      scheduleUrl: json['scheduleUrl'],
      studentScheduleUrl: json['studentScheduleUrl'],
    );
  }
}
