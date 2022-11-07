
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rent_manager/app/model/building.dart';
import 'package:rent_manager/app/model/flat.dart';


class FlatController extends GetxController {
  final Box _box = Hive.box<Flat>('flats');

  Box get flat => _box;

  bool isDeleteInProgress = false;

  createFlat({required Flat flat}) {
    _box.add(flat);
    update();
  }

  updateFlat({required int key, required Flat flat}) {
    _box.put(key, flat);
    update();
  }

  deleteFlat({required int key}) {
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

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }
}
