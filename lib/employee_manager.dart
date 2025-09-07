import 'dart:convert';
import 'package:employee_manager/employee.dart';
import 'dart:io';


class EmployeeManager {
  List<Employee> employees = [];
  final String fileName = "employees.json";     // So it would be easy to read/write/create anything on/in "employees.json"

  // Here we have "addEmployees" which have 3 parts (Get value, verify, adding how many employees)
  void addEmployees() {
    stdout.write("Enter how many employees you want to fill their information: \n");
    int numberOfEmployees;
    try { // (Second) part to verify if the user have the correct input
      numberOfEmployees = int.parse(stdin.readLineSync()!); // (First) part to get the value from the user
    } catch (e) {
      stdout.write("Wrong number, returning to the first menu\n");
      return;
    }

    // (Third) part to add how many employees
    for (int i = 0; i < numberOfEmployees; i++) {
      try {
        // {i+1} because index in programming we start from 0 but in human world we don't. so if the user choosed to add only
        // 1 employee info then it would be like "hey index let's start to fill employee number 1 not employee number 0" 
        stdout.write("--Enter the details for the employee number ${i + 1} --\n");

        // Here we fill every varibles we got from other classes with making sure it's not NULL 
        stdout.write("Enter employee name:\n");
        String? nameEntered = stdin.readLineSync()!;
        stdout.write("Enter employee age:\n"); // Caught Try not working
        int ageEntered = int.parse(stdin.readLineSync()!);
        stdout.write("Enter employee position:\n");
        String positionEntered = stdin.readLineSync()!;
        stdout.write("Enter employee monthly salary:\n");
        double monthlySalaryEntered = double.parse(stdin.readLineSync()!);

        // from "employee.dart" get veribles and name them here as name = name, age = age,... etc
        Employee employee = Employee.withPosition(
            name: nameEntered, age: ageEntered, position: positionEntered, monthlySalary: monthlySalaryEntered);
        employees.add(employee);
        //stdout.write("Employee has been added\r");
      } catch (e) {
        stdout.write("Error: $e\n");
      }
    }
  }

  // Here where we have "display" 
  void displayEmployees() {
    if (employees.isEmpty) {
      stdout.write("You haven't entered anything.\n");
      return;
    }
    stdout.write("====== Employee List ======\n");
    for (var employee in employees) {  // here we said to the compiler "make a variable named employee and make it get it values from"
      employee.displayInfo();         // and make it get it values from (employees)" which's a List we have created in the first lines
    }
  }

  // Sotring by name, age, and monthly salary
  void sortingEmployees() {
    if (employees.isEmpty) {
      stdout.write("There're no employees to sort\n");
      return;
    }
    stdout.write("Sorting by:\n");
    stdout.write("1- Name\n");
    stdout.write("2- Age\n");
    stdout.write("3- Monthly Salary\n");
    stdout.write("Choose one of the 3 options (type a number 1,2, or 3): ");
    String? choice = stdin.readLineSync(); // Here we get the value so we know which one to sort by

    switch (choice) {
      case '1':
        employees.sort((a, b) => a.name.compareTo(b.name));      // BONUS (2): "Add sorting feature: Allow 
        stdout.write("Sorted by name\n");                       // the user to sort employees by
        break;                                                 // age, name, or salary before printing the report"
      case '2':
        employees.sort((a, b) => a.age.compareTo(b.age)); // I HAVE AN ERROR HERE
        stdout.write("Sorted by age\n"); 
        break;
      case '3':
        employees.sort((a, b) => a.monthlySalary.compareTo(b.monthlySalary)); // "a" & "b" are for comparing method in dart  
        stdout.write("Sorted by monthly salary\n");
        break;
      default:
        stdout.write("Wrong number, you need to choose one of the 3 options\n");
    }
  }

  // Here where we have created a filter method by filtering either by Salary or Position
  void filterEmployees() {
    if (employees.isEmpty) {
      stdout.write("There're no employees to filter\n");
      return;
    }
    stdout.write("\nFilter by\n");
    stdout.write("1- Position\n");
    stdout.write("2- Salary range\n");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();     // Getting the values

    switch (choice) {
      case "1":
        stdout.write("Type position to filter by: ");
        String? position = stdin.readLineSync();                // Here's the "position" filter from BONUS (3) req
        var filtered =  // (Err3) as you see under my comment. I made it automatcly and got a lot of time to find how I created it
            employees.where((element) => element.position == position).toList();  // BONUS (3): Add filtering feature:
        if (filtered.isEmpty) {                                                  // Allow filtering employees by position
          stdout.write("There're no employees with the position $position\n");  // or salary range when displaying the report
        } else {
          stdout.write("\nFiltered employees:\n");
          for (var employee in filtered) {
            employee.displayInfo();
          }
        }
        break;
      case "2":
        stdout.write("Type the minimum salary: ");                        // Here's the "salary range" filter from BONUS (3) req
        double minSalary;
        try {   // Handling errors
          minSalary = double.parse(stdin.readLineSync()!);    // I got a lot of errors here where I have typed "minSalary?" so
        } catch (e) {                                        // typed "minSalary?" so I won't get errors but I did got a lot of erros
          stdout.write("Wrong minimum salary, returning to the old menu\n");  // until I removed it. 
          return;
        }
        stdout.write("\nType the maximum salary: ");
        double maxSalary;
        try {
          maxSalary = double.parse(stdin.readLineSync()!);  // Same thing happend here
        } catch (e) {
          stdout.write("Wrong maximum salary, returning to the old menu\n");
          return;
        }
        var filtered = employees
            .where((element) =>
                element.monthlySalary >= minSalary &&
                element.monthlySalary <= maxSalary) // The error I have told eariler was happened here. it was like a conflict
            .toList();                          // I was wondering what I have missed. one of the reasons was "element"
        if (filtered.isEmpty) {             // which it have been created automaticly after I choosed to in part number (Err3) above
          stdout.write(
              "No employee found between the range of \$$maxSalary to \$$minSalary");
        } else {
          stdout.write("\nFiltered Employees: ");
          for (var employee in filtered) {
            employee.displayInfo();
          }
        }
        break;
      default:
        stdout.write("Wrong choice, returning to the old menu\n");
    }
  }

  void saveEmployeeToJSON() {        // BONUS(1): "Save and load employees to/from a JSON file to persist data across program runs."
    try {
      var jsonData = jsonEncode(employees.map((e) => e.toJson()).toList());
      File(fileName).writeAsStringSync(jsonData);
      stdout.write("Employees saved to '$fileName'\n");
    } catch (e) {
      stdout.write("Error saving employees: $e\n");
    }
  }

  void loadEmployeeFromJSON() {       // BONUS(1): "Save and load employees to/from a JSON file to persist data across program runs."
    try {
      var jsonData = File(fileName).readAsStringSync();
      var decoded = jsonDecode(jsonData) as List<dynamic>;
      employees = decoded
          .map((e) => Employee.fromJSON(e as Map<String, dynamic>))
          .toList();
      stdout.write("Employees loaded from $fileName\n");
    } catch (e) {
      stdout.write("Error loading employees: $e\n");
    }
  }
}