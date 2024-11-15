class ServiceAI {
  final int id;
  final String name;
  final String? images;
  final int? titleId;

  ServiceAI({
    required this.id,
    required this.name,
    this.images,
    this.titleId,
  });

  // Factory constructor for creating an instance from JSON
  factory ServiceAI.fromJson(Map<String, dynamic> json) {
    return ServiceAI(
      id: json['id'],
      name: json['name'],
      images: json['images'] as String?,
      titleId: json['titleId'],
    );
  }

  // Method to create a copy with modified fields
  ServiceAI copyWith({
    int? id,
    String? name,
    String? images,
    int? titleId,
  }) {
    return ServiceAI(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      titleId: titleId ?? this.titleId,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'titleId': titleId,
    };
  }
}
