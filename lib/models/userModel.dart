class UserModel {
  String avatar;
  String name;
  String phone;
  String email;
  String id;
  String type;
  String? token;
  String gender;
  String? birthDate;
  String? address;
  String? typeCar;
  String? idCard;
  String? descriptionCar;
  Map<String, dynamic>? inforDriver;
  String? license_plate;
  String? nameCar;
  double? rating;
  int? number_of_trips;
  int? successResult;
  UserModel({
    required this.avatar,
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.type,
    required this.gender,
    this.birthDate,
    this.token,
    this.address,
    this.typeCar,
    this.idCard,
    this.descriptionCar,
    this.inforDriver,
    this.license_plate,
    this.nameCar,
    this.rating,
    this.number_of_trips,
    this.successResult
  });
}
