class Entity {
  final int id;
  final int? carId;
  final int? userId;
  final String? activeStatus;
  final double? mileage;
  final String? mileageUnit;
  final String? fuelType;
  final String? serviceDate;
  final double? dailyFuelExpenditure;
  final double? monthlyFuelExpenditure;
  final String? currencyType;
  final String? name;
  final String? model;
  final int? year;
  final String? trim;
  final String? engine;
  final String? power;
  final String? torque;
  final String? transmission;
  final String? drivetrain;
  final String? acceleration;
  final String? fuelConsumption;
  final int? images;

  Entity({
    required this.id,
    this.carId,
    this.userId,
    this.activeStatus,
    this.mileage,
    this.mileageUnit,
    this.fuelType,
    this.serviceDate,
    this.dailyFuelExpenditure,
    this.monthlyFuelExpenditure,
    this.currencyType,
    this.name,
    this.model,
    this.year,
    this.trim,
    this.engine,
    this.power,
    this.torque,
    this.transmission,
    this.drivetrain,
    this.acceleration,
    this.fuelConsumption,
    this.images,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json['id'],
      carId: json['carId'],
      userId: json['userId'],
      activeStatus: json['activeStatus'],
      mileage: (json['mileage'] as num?)?.toDouble(),
      mileageUnit: json['mileageUnit'],
      fuelType: json['fuelType'],
      serviceDate: json['serviceDate'],
      dailyFuelExpenditure: (json['dailyFuelExpenditure'] as num?)?.toDouble(),
      monthlyFuelExpenditure:
          (json['monthlyFuelExpenditure'] as num?)?.toDouble(),
      currencyType: json['CurrencyType'],
      name: json['name'],
      model: json['model'],
      year: json['year'],
      trim: json['trim'],
      engine: json['engine'],
      power: json['power'],
      torque: json['torque'],
      transmission: json['transmission'],
      drivetrain: json['drivetrain'],
      acceleration: json['acceleration'],
      fuelConsumption: json['fuel_consumption'],
      images: json['images'],
    );
  }

  // Adding the copyWith method
  Entity copyWith({
    int? id,
    int? carId,
    int? userId,
    String? activeStatus,
    double? mileage,
    String? mileageUnit,
    String? fuelType,
    String? serviceDate,
    double? dailyFuelExpenditure,
    double? monthlyFuelExpenditure,
    String? currencyType,
    String? name,
    String? model,
    int? year,
    String? trim,
    String? engine,
    String? power,
    String? torque,
    String? transmission,
    String? drivetrain,
    String? acceleration,
    String? fuelConsumption,
    int? images,
  }) {
    return Entity(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      userId: userId ?? this.userId,
      activeStatus: activeStatus ?? this.activeStatus,
      mileage: mileage ?? this.mileage,
      mileageUnit: mileageUnit ?? this.mileageUnit,
      fuelType: fuelType ?? this.fuelType,
      serviceDate: serviceDate ?? this.serviceDate,
      dailyFuelExpenditure: dailyFuelExpenditure ?? this.dailyFuelExpenditure,
      monthlyFuelExpenditure:
          monthlyFuelExpenditure ?? this.monthlyFuelExpenditure,
      currencyType: currencyType ?? this.currencyType,
      name: name ?? this.name,
      model: model ?? this.model,
      year: year ?? this.year,
      trim: trim ?? this.trim,
      engine: engine ?? this.engine,
      power: power ?? this.power,
      torque: torque ?? this.torque,
      transmission: transmission ?? this.transmission,
      drivetrain: drivetrain ?? this.drivetrain,
      acceleration: acceleration ?? this.acceleration,
      fuelConsumption: fuelConsumption ?? this.fuelConsumption,
      images: images ?? this.images,
    );
  }

  // toJson method for Entity
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carId': carId,
      'userId': userId,
      'activeStatus': activeStatus,
      'mileage': mileage,
      'mileageUnit': mileageUnit,
      'fuelType': fuelType,
      'serviceDate': serviceDate,
      'dailyFuelExpenditure': dailyFuelExpenditure,
      'monthlyFuelExpenditure': monthlyFuelExpenditure,
      'CurrencyType': currencyType,
      'name': name,
      'model': model,
      'year': year,
      'trim': trim,
      'engine': engine,
      'power': power,
      'torque': torque,
      'transmission': transmission,
      'drivetrain': drivetrain,
      'acceleration': acceleration,
      'fuel_consumption': fuelConsumption,
      'images': images,
    };
  }
}
