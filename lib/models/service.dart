class Service {
  final int id;
  final int userId;
  final String? item;
  final String? description;
  final String? status;
  final int? date;
  final int? time;

  Service({
    required this.id,
    required this.userId,
    this.item,
    this.description,
    this.date,
    this.time,
    this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      userId: json['userId'],
      item: json['item'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }

  Service copyWith({
    int? id,
    int? userId,
    String? item,
    String? description,
    String? status,
    int? date,
    int? time,
  }) {
    return Service(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      item: item ?? this.item,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'item': item,
      'description': description,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
