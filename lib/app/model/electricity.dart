
import 'package:hive/hive.dart';

import 'meter_type.dart';

part 'electricity.g.dart';

@HiveType(typeId: 0)
class Electricity extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double meterSerialNo;
  @HiveField(3)
  MeterType meterType;
  @HiveField(4)
  double numberOfBalconies;
  @HiveField(5)
  double waterMeterId;
  @HiveField(6)
  double gasMeterId;
  @HiveField(7)
  double electricityMeterId;
  @HiveField(8)
  double flatOnFloorNumber;

  Flat({
    required this.id,
    required this.name,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
    required this.numberOfBalconies,
    required this.waterMeterId,
    required this.gasMeterId,
    required this.electricityMeterId,
    required this.flatOnFloorNumber
  });

  Flat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        numberOfRooms = json['numberOfRooms'],
        numberOfBathrooms = json['numberOfBathrooms'],
        numberOfBalconies = json['numberOfBalconies'],
        waterMeterId = json['waterMeterId'],
        gasMeterId = json['gasMeterId'],
        electricityMeterId = json['electricityMeterId'],
        flatOnFloorNumber = json['flatOnFloorNumber'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'numberOfRooms': numberOfRooms,
      'numberOfBathrooms': numberOfBathrooms,
      'numberOfBalconies': numberOfBalconies,
      'waterMeterId': waterMeterId,
      'gasMeterId': gasMeterId,
      'electricityMeterId': electricityMeterId,
      'flatOnFloorNumber': flatOnFloorNumber
    };
  }
}