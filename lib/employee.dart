import 'package:employee_manager/person.dart';
import 'dart:io';

class Employee extends Person {
  String position;
  double monthlySalary;

  // Here to take values from this class and from the extended class Person to send it to the main
  Employee.withPosition({ 
    required String name,               // "required" here because we opened a brackets to make the code clean and readable and when we
    required int age,                  // do open brackets we need to make it as same as Map syntax but it is NOT a Map. 
    required this.position,
    required this.monthlySalary,
    }): super(name,age){    // I have created a "try" here to make it handle the errors depending of the type of the erorr
      try {
        if (age<18) {                    // Req1 from the PDF, 18 or older
          throw ArgumentError("Age must be 18 or older");          
        }
        if (name.trim().isEmpty) {        // Req2 from the PDF, not empty or white space
          throw ArgumentError("You need to enter a name, don't make it empty");
        }
        if (position.trim().isEmpty) {    // Req3 from the PDF, not empty or white space
          throw ArgumentError("You need to enter a position, don't make it empty");
        }
        if (monthlySalary<=0) {           // Req4 from the PDF, must be more than 0
          throw ArgumentError("Monthly Salary can't be zero or negative");          
        }
      } catch (e) {       // "Throw exceptions if validation fails"
        stdout.write("Validattion Error $e");
      } 
    }


    // Overridding "displayInfo" from person.dart. Will be printed in main 
  @override
  void displayInfo(){
    stdout.write("--- Employee Info ---\n");
    stdout.write("Name: $name\n");
    stdout.write("Age: $age\n");
    stdout.write("Position: $position\n");
    stdout.write("Monthly Salary: \$$monthlySalary\n");
    stdout.write("Yearly Salary: \$${monthlySalary*12}\n");
  }

  // To convert from Employee to JSON
  Map<String, dynamic> toJson(){
    return{
      "name":name,
      "age":age,
      "position":position,
      "monthlySalary":monthlySalary,
    };
  }

  // To create Employee from JSON
  factory Employee.fromJSON(Map<String, dynamic> json){   // factory is as same as function but the different's
    return Employee.withPosition(                        // factory can handle more complex things,
      name: json["name"],                               // as you see here, we are handling more complex thing (json) 
      age: json["age"],                                // without getting any problems 
      position: json["position"], 
      monthlySalary: json["monthlySalary"].toDouble(),
      );
  }  
}