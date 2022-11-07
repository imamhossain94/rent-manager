
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rent_manager/app/model/building.dart';


class BuildingController extends GetxController {
  final Box _box = Hive.box<Building>('buildings');

  Box get building => _box;

  bool isDeleteInProgress = false;

  createBuilding({required Building building}) {
    _box.add(building);
    update();
  }

  updateBuilding({required int key, required Building building}) {
    _box.put(key, building);
    update();
  }

  deleteBuilding({required int key}) {
    _box.delete(key);
    update();
  }

  Future delete(BuildContext context, String delete) async {
    isDeleteInProgress = true;
    update();
    var result = await Future.delayed(const Duration(milliseconds: 500), () async {
      var value = await _box.clear();
      isDeleteInProgress = false;
      update();
      return value;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(delete)));
    return result;
  }

  deleteAll() {
    _box.clear();
    update();
  }

  // @override
  // void onClose() {
  //   Hive.close();
  //   super.onClose();
  // }
}
