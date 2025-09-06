import 'dart:convert';
//import 'dart:math';
import 'package:employee_manager/employee.dart';
import 'dart:io';

void main(){
  List<Employee> employees=[];
  const String fileName="employees.json";

  while (true) {
    stdout.write("\nChoose what you wanna do\n");
    stdout.write("1- Add an employee\n");
    stdout.write("2- Display employees\n");
    stdout.write("3- Sort employee\n");
    stdout.write("4- Filter employee\n");
    stdout.write("5- Save employees to JSON\n");
    stdout.write("6- Load employees from JSON\n");
    stdout.write("7- Format JSON\n");
    stdout.write("8- Exit\n");
    stdout.write("Type the number here: ");
    String? entery= stdin.readLineSync();

    switch (entery) {
      case "1":
        addEmployees(employees);
        break;
      case "2":
        displayEmployees(employees);
        break;
      case "3":
        sortingEmployees(employees);
        displayEmployees(employees);
        break;
      case "4":
        filterEmployees(employees);
        break;
      case "5":
        saveEmployeeToJSON(employees, fileName);
        break;
      case "6":
        employees = loadEmployeeFromJSON(fileName);
        break;
      case "7":
      // I havn't finished it yet
        break;
      case "8":
      stdout.write("Exting program in progress..");
      return;
      default:
      stdout.write("Wrong option, try again\n");
    }
  }
}
  void addEmployees(List<Employee> employees) {
  stdout.write("Enter how many employees you want to fill their information: \n");
  int numberOfEmployees;
  try {
    numberOfEmployees = int.parse(stdin.readLineSync()!);
  } catch (e) {
      stdout.write("Wrong numbmer, returning to the first menu\n");
      return;
    }

     for(int i=0; i < numberOfEmployees; i++){
      try {
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
    stdout.write("Employee have been added\r");
    } catch (e) {
      stdout.write("Error $e\n");
      }
    }
  }

  void displayEmployees(List<Employee> employees){
    if(employees.isEmpty){
      stdout.write("You havn't entered anything.\n");
      return;
    }
    stdout.write("====== Employee List ======\n");
    for (var employee in employees){
      employee.displayInfo();
    }
  }

  void sortingEmployees(List<Employee> employees){
    if (employees.isEmpty){
      stdout.write("There're no employees to sort\n");
      return;
    }
    stdout.write("Sorting by:\n");
    stdout.write("1- Name\n");
    stdout.write("2- Age\n");
    stdout.write("3- Monthly Salary\n");
    stdout.write("Choose one of the 3 options (type a number 1,2, or 3): ");
    String? choice=stdin.readLineSync();

  switch (choice) {
    case '1':
      employees.sort((a, b) => a.name.compareTo(b.name));
      stdout.write("Sorted by name\n");
      break;
    case '2':
      employees.sort((a, b) => a.age.compareTo(b.age));
      stdout.write("Sorted by age\n");
      break;
    case '3':
      employees.sort((a, b) => a.monthlySalary.compareTo(b.monthlySalary));
      stdout.write("Sorted by monthly salary\n");
      break;
    default:
    stdout.write("wrong number, you need to choose one of the 3 options\n");
  }
}
  void filterEmployees(List<Employee> employees){
    if (employees.isEmpty) {
      stdout.write("There're no employee to filter\n");
      return;
    }
    stdout.write("\nFilter by\n");
    stdout.write("1- Position\n");
    stdout.write("2- Salary range\n");
    stdout.write("Choose an option: ");
    String? choice= stdin.readLineSync();

    switch (choice) {
      case "1":
        stdout.write("Type position to filter by: ");
        String? position = stdin.readLineSync();
        var filtered = employees.where((element) => element.position == position).toList();
        if (filtered.isEmpty){
          stdout.write("There're no employee with the position $position\n");
        } else {
          stdout.write("\nFiltered employee:\n");
          for (var employee in filtered){
            employee.displayInfo();
          }
        }
        break;
      case "2":
        stdout.write("Type the minimum salary: ");
        double minSalary;
        try{
          minSalary = double.parse(stdin.readLineSync()!);
         } catch (e) {
          stdout.write("Wrong minimum salary, returning to the old menu\n");
          return;
        }
        stdout.write("\nType the maxmum salary: ");
        double maxSalary;
        try{
          maxSalary = double.parse(stdin.readLineSync()!);
        } catch (e) {
          stdout.write("Wrong maxmum salary, returning to the old menu\n");
          return;
        }
        var filtered= employees
        .where((element) =>
         element.monthlySalary >= minSalary &&
         element.monthlySalary <= maxSalary)
         .toList();
         if (filtered.isEmpty){
           stdout.write("No employee found between the range of \$$maxSalary to \$$minSalary");
         } else {
           stdout.write("\nFiltered Employees: ");
           for(var employee in filtered){
             employee.displayInfo();
           }
        }
         break;
     default:
    stdout.write("Wrong choice, returning to the old menu\n");
  }
}

  void saveEmployeeToJSON(List<Employee> employees, String fileName){
    try{
      var jsonData = jsonEncode(employees.map((e) => e.toJson()).toList());
      File(fileName).writeAsStringSync(jsonData);
      stdout.write("Employees saved to '$fileName'\n");
    } catch (e) {
      stdout.write("Error saving employees: $e\n");
    }
  }

  List<Employee> loadEmployeeFromJSON(String fileName){
    try {
      var jsonData = File(fileName).readAsStringSync();
      var decoded = jsonDecode(jsonData) as List<dynamic>;
      var employees = decoded.map((e) => Employee.fromJSON(e as Map<String, dynamic>)).toList();
      stdout.write("Employee loaded from $fileName\n");
      return employees;
    } catch (e) {
      stdout.write("Error loading from Employee: $e\n");
      return [];
    }
  }