
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rent_manager/app/model/building.dart';
import 'package:uuid/uuid.dart';

import '../model/flat.dart';
import '../model/floor.dart';

class BuildingViewModel extends GetxController {
  final Rx<String> uid;
  BuildingViewModel({required String uid})
      : uid = Rx(uid);

  final Box _box = Hive.box<Building>('buildings');

  Rxn<Building> building = Rxn<Building>();
  RxList<Floor> floors = <Floor>[].obs;
  RxMap<String, List<Flat>> flats = <String, List<Flat>>{}.obs;

  List<String> floorsLabels = ['Ground', '1st', '2nd', '3rd',
    '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th',
    '12th', '13th', '14th', '15th', '16th', '17th', '18th',
    '19th', '20th', '21th', '22th', '23th', '24th', '25th', '26th'];

  List<String> flatsLabels = ['G', 'A', 'B', 'C', 'D', 'E',
    'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
    'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

  TextEditingController buildingsNameTextEditingController = TextEditingController();


  @override
  void onInit() {
    building(Building(
        id: uid.value,
        name: buildingsNameTextEditingController.text.toString(),
        floors: floors,
        isFavorite: false));
    super.onInit();
  }

  @override
  void dispose() {
    buildingsNameTextEditingController.dispose();
    super.dispose();
  }

  void createFloor(int index) {
    var id = const Uuid().v1();
    flats[id] = [];
    floors.add(
      Floor(
          id: id,
          buildingId: uid.value,
          name: "${floorsLabels[index]} Floor",
          flats: flats[id]!));
  }

  void createFlat(String id, int floorIndex, int flatIndex) {
    flats[id]?.add(Flat(
        id: const Uuid().v1(),
        buildingId: uid.value,
        floorId: uid.value,
        name: "${flatsLabels[floorIndex]}-${flatIndex+1}"));
    flats.refresh();
    update();
  }

  void saveBuilding() {
    var buildingName = buildingsNameTextEditingController.text.toString();
    if(buildingName != "") {
      building.value!.name = buildingName;
      _box.add(building.value);
    }
  }


  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

}
