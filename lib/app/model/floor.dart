import 'package:hive/hive.dart';

import 'flat.dart';

part 'floor.g.dart';

@HiveType(typeId: 1)
class Floor extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String buildingId;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<Flat> flats;


  Floor({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.flats,
  });

  Map<String, dynamic> toJson() {
    return {
      'i': id,
      'bi': buildingId,
      'n': name,
      'f': flats
    };
  }

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
        id: json['i'],
        buildingId: json['bi'],
        name: json['n'],
        flats: (json['f'] as List).map((data) => Flat.fromJson(data)).toList());
  }

}
