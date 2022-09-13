
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PaymentRecord extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String meterId;
  @HiveField(2)
  DateTime paymentDate;
  @HiveField(3)
  double amount;
  @HiveField(4)
  String receiptNo;

  PaymentRecord({
    required this.id,
    required this.meterId,
    required this.paymentDate,
    required this.amount,
    required this.receiptNo,
  });

  PaymentRecord.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        meterId = json['meterId'],
        paymentDate = json['paymentDate'],
        amount = json['amount'],
        receiptNo = json['receiptNo'];


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meterId': meterId,
      'paymentDate': paymentDate,
      'amount': amount,
      'receiptNo': receiptNo
    };
  }

}

