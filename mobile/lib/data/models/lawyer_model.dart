class LawyerModel {
  final String id;
  final String name;
  final String specialty;
  final String contactEmail;
  final String phone;

  LawyerModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.contactEmail,
    required this.phone,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      contactEmail: json['contactEmail'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
