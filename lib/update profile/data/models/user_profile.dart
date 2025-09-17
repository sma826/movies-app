class UserProfile {
  final String id;
  final String name;
  final String phone;
  final int avaterId;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.avaterId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return UserProfile(
      id: data['_id'],
      name: data['name'],
      phone: data['phone'],
      avaterId: data['avaterId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'avaterId': avaterId};
  }
}
