class Hospital {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String type;
  final double distance;
  final double rating;
  final String imageUrl;

  Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.type,
    this.distance = 0.0,
    this.rating = 0.0,
    this.imageUrl = "https://i.pravatar.cc/150?img=12", // Default mock image
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      type: json['type'],
    );
  }
}
