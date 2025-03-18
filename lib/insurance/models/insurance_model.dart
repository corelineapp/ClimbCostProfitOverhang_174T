import 'package:hive/hive.dart';

part 'insurance_model.g.dart';

@HiveType(typeId: 1)
class InsuranceModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime date;

  InsuranceModel({
    required this.name,
    required this.date,
  });
}
