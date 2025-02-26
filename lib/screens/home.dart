import 'package:flutter/material.dart';

import '../models/employee.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Empleados')),
      body: StreamBuilder<List<Employee>>(
        stream: Employee().getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay empleados.'));
          }

          final employees = snapshot.data!;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return ListTile(
                title: Text(employee.name),
                subtitle: Text(employee.position),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showEmployeeDialog(employee: employee),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await employee.delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEmployeeDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEmployeeDialog({Employee? employee}) {
    final nameController = TextEditingController(text: employee?.name);
    final positionController = TextEditingController(text: employee?.position);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(employee == null ? 'Nuevo Empleado' : 'Editar Empleado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nombre')),
              TextField(controller: positionController, decoration: InputDecoration(labelText: 'Puesto')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty || positionController.text.isEmpty) return;
                
                final newEmployee = Employee(
                  id: employee?.id ?? '',
                  name: nameController.text,
                  position: positionController.text,
                  startDate: employee?.startDate ?? DateTime.now(),
                  startTime: employee?.startTime ?? DateTime.now(),
                  endTime: employee?.endTime ?? DateTime.now(),
                  workingDays: employee?.workingDays ?? [],
                  salary: employee?.salary ?? 0.0,
                  employmentType: employee?.employmentType ?? 'full-time',
                  status: employee?.status ?? 'active',
                );
                await newEmployee.save();
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
