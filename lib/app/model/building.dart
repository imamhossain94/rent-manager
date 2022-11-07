
import 'package:hive/hive.dart';

import 'floor.dart';

part 'building.g.dart';

@HiveType(typeId: 0)
class Building extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  final List<Floor> floors;
  @HiveField(3)
  final bool isFavorite;

  Building({
    required this.id,
    required this.name,
    required this.floors,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'i': id,
      'n': name,
      'f': floors,
      'isf': isFavorite,
    };
  }

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
        id: json['i'],
        name: json['n'],
        floors: (json['f'] as List).map((data) => Floor.fromJson(data)).toList(),
        isFavorite: json['isf']);
  }
}
