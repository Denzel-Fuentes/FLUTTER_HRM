import 'base_model.dart';

class Employee extends BaseModel<Employee> {
  String name;
  DateTime startDate;
  double salary;
  String position;
  String employmentType; // 'full-time', 'part-time', 'contract'
  String status; // 'active', 'terminated', 'on_leave'
  DateTime startTime;
  DateTime endTime;
  List<String> workingDays; 
  String? email;
  String? phone;

  Employee({
    String id = '',
    this.name = 'John Doe',
    this.position = 'Employee',
    DateTime? startDate,
    DateTime? startTime,
    DateTime? endTime,
    this.workingDays = const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
    this.salary = 50000.0,
    this.employmentType = 'full-time',
    this.status = 'active',
    this.email,
    this.phone,
  })  : startDate = startDate ?? DateTime.now(),
        startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now().add(Duration(hours: 8));

  @override
  String get collection => 'employees';

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'startDate': startDate.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'salary': salary,
      'employmentType': employmentType,
      'status': status,
      'email': email,
      'phone': phone,
    };
  }

  @override
  Employee fromMap(String id, Map<String, dynamic> data) {
    return Employee(
      id: id,
      name: data['name'] ?? 'John Doe',
      position: data['position'] ?? 'Employee',
      startDate: DateTime.parse(data['startDate'] ?? DateTime.now().toIso8601String()),
      startTime: DateTime.parse(data['startTime'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(data['endTime'] ?? DateTime.now().add(Duration(hours: 8)).toIso8601String()),
      salary: (data['salary'] ?? 50000.0).toDouble(),
      workingDays: List<String>.from(data['workingDays'] ?? ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']),
      employmentType: data['employmentType'] ?? 'full-time',
      status: data['status'] ?? 'active',
      email: data['email'],
      phone: data['phone'],
    );
  }
}
