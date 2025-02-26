import 'base_model.dart';

class Payroll extends BaseModel<Payroll> {
  String employeeId;
  DateTime periodStart;
  DateTime periodEnd;
  double baseSalary;
  DateTime paymentDate;

  Payroll({
    String id = '',
    required this.employeeId,
    required this.periodStart,
    required this.periodEnd,
    required this.baseSalary,
    required this.paymentDate,
  }) {
    this.id = id;
  }

  @override
  String get collection => 'payrolls';

  @override
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'periodStart': periodStart.toIso8601String(),
      'periodEnd': periodEnd.toIso8601String(),
      'baseSalary': baseSalary,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }

  @override
  Payroll fromMap(String id, Map<String, dynamic> data) {
    return Payroll(
      id: id,
      employeeId: data['employeeId'] ?? '',
      periodStart: DateTime.parse(data['periodStart'] ?? DateTime.now().toIso8601String()),
      periodEnd: DateTime.parse(data['periodEnd'] ?? DateTime.now().toIso8601String()),
      baseSalary: (data['baseSalary'] ?? 0).toDouble(),
      paymentDate: DateTime.parse(data['paymentDate'] ?? DateTime.now().toIso8601String()),
    );
  }
}
