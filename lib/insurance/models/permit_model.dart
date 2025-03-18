import 'package:hive/hive.dart';

part 'permit_model.g.dart';

@HiveType(typeId: 0)
class Permit extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime expiryDate;

  Permit({required this.type, required this.amount, required this.expiryDate});
}
