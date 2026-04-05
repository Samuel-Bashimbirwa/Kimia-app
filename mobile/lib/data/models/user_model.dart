class UserModel {
  final String id;
  final String pseudo;
  final String? email;
  final String? phone;
  final String? emergencyContact;
  final String? avatarUrl;
  final String role;

  UserModel({
    required this.id,
    required this.pseudo,
    this.email,
    this.phone,
    this.emergencyContact,
    this.avatarUrl,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      pseudo: json['pseudo'] ?? '',
      email: json['email'],
      phone: json['phone'],
      emergencyContact: json['emergencyContact'],
      avatarUrl: json['avatarUrl'],
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pseudo': pseudo,
      'email': email,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'avatarUrl': avatarUrl,
    };
  }
}
