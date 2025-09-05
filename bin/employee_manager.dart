import 'package:employee_manager/employee.dart';
import 'dart:io';

void main(){
  List<Employee> employees=[];
  stdout.write("Enter how many employee you want to fill their information: ");
  int numEmployees=int.parse(stdin.readLineSync()!);
  for(int i=0; i < numEmployees; i++){
    stdout.write("--Enter the details for the employee number ${i+1} --\n");
    
    stdout.write("Enter employee name:\n");
    String? name=stdin.readLineSync()!;
    stdout.write("Enter employee age:\n");
    int age=int.parse(stdin.readLineSync()!);
    stdout.write("Enter employee position:\n");
    String position=stdin.readLineSync()!;
    stdout.write("Enter employee monthly salary:\n");
    double monthlySalary=double.parse(stdin.readLineSync()!);

    Employee employee= Employee.withPosition(name: name, age: age, position: position, monthlySalary: monthlySalary);
    employees.add(employee);
    employee.displayInfo();


  }
}