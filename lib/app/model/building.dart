
import 'package:hive/hive.dart';

import 'flat.dart';

part 'building.g.dart';

@HiveType(typeId: 0)
class Building extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double numberOfFloors;
  @HiveField(2)
  final double numberOfUnitsInEachFloor;

  @HiveField(2)
  final List<Flat> spices;
  @HiveField(3)
  final bool isFavorite;


  Building({
    required this.name,
    required this.quantity,
    required this.spices,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'n': name,
      'q': quantity,
      's': spices,
      'i': isFavorite,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['n'],
        quantity: json['q'],
        spices:
            (json['s'] as List).map((data) => Spice.fromJson(data)).toList(),
        isFavorite: json['i']);
  }
}
