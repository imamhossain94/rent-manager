import 'package:hive/hive.dart';

part 'flat.g.dart';

@HiveType(typeId: 2)
class Flat extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String buildingId;
  @HiveField(2)
  String floorId;
  @HiveField(3)
  String name;

  Flat({
    required this.id,
    required this.buildingId,
    required this.floorId,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'i': id,
      'bi': buildingId,
      'fi': floorId,
      'n': name
    };
  }

  factory Flat.fromJson(Map<String, dynamic> json) {
    return Flat(
        id: json['i'],
        buildingId: json['bi'],
        floorId: json['fi'],
        name: json['n']);
  }

}
