class Contact {
  int? id;
  String name;
  String phone;
  String email;
  bool isFavorite;
  String image;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isFavorite = false,
    required this.image,
  });

  // Convert Contact to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'isFavorite': isFavorite ? 1 : 0,
      'image': image,
    };
  }

  // Create a Contact from Map
 factory Contact.fromMap(Map<String, dynamic> map) {
  return Contact(
    id: map['id'],
    name: map['name'] ?? '', // Default to an empty string if null
    phone: map['phone'] ?? '', // Default to an empty string if null
    email: map['email'] ?? '', // Default to an empty string if null
    isFavorite: map['isFavorite'] == 1,
    image: map['image'] ?? '', // Default to an empty string if null
  );
}

}
