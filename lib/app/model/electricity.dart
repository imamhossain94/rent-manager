
import 'package:hive/hive.dart';
import 'package:rent_manager/app/model/payment_record.dart';

import 'meter_type.dart';
import 'who_will_pay.dart';

part 'electricity.g.dart';

@HiveType(typeId: 0)
class ElectricityMainMeter extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String meterSerialNo;
  @HiveField(2)
  double meterLabel;
  @HiveField(3)
  MeterType meterType;
  @HiveField(4)
  WhoWillPay whoWillPay;

  ElectricityMainMeter({
    required this.id,
    required this.meterSerialNo,
    required this.meterLabel,
    required this.meterType,
    required this.whoWillPay,
  });

  ElectricityMainMeter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        meterSerialNo = json['meterSerialNo'],
        meterLabel = json['meterLabel'],
        meterType = json['meterType'],
        whoWillPay = json['whoWillPay'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meterSerialNo': meterSerialNo,
      'meterLabel': meterLabel,
      'meterType': meterType,
      'whoWillPay': whoWillPay
    };
  }
}