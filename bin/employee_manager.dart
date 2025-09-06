import 'dart:io';

import 'package:employee_manager/employee_manager.dart';

void main(){

  /*  
      Calling "EmployeeManager" class as "manager". which have all the operations
      I made it this way since it was a chaois and more than 200 line here
  */
  EmployeeManager manager = EmployeeManager(); 

  while (true) { // Req2: (Loop to collect data for each employee)
    stdout.write("\nChoose what you wanna do\n");

    // Req1: "Ask the user for the number of employees to add". 
    // here it is in the main as you see in (1) but the operation will be in ../lib/employee_manager.dart for clean code 
    stdout.write("1- Add an employee\n"); //(1)
    stdout.write("2- Display employees\n");
    stdout.write("3- Sort employee\n");
    stdout.write("4- Filter employee\n");
    stdout.write("5- Save employees to JSON\n");
    stdout.write("6- Load employees from JSON\n");
    stdout.write("7- Exit\n");
    stdout.write("Type the number here: ");
    String? entery= stdin.readLineSync();   // Here we get the value of the user. "entery" is the value we will use later


      // Req3: "Try to create an Employee object for each input; catch and print errors without stopping" 
      // Employee is in "employee.dart" for clean code.
      // Req4: "After input, print all valid employees’ info." it is here in (2)
    switch (entery) {   
      case "1":
        manager.addEmployees();  // (2) but as I have said before, it is in "../lib/employee_manager.dart" for clean code. 
        break; // it would be more than 200 line if we just combained "./bin/employee_manager.dart" with "../lib/employee_manager.dart"
      case "2":
        manager.displayEmployees();
        break;
      case "3":
        manager.sortingEmployees();
        manager.displayEmployees();
        break;
      case "4":
        manager.filterEmployees();
        break;
      case "5":
        manager.saveEmployeeToJSON();
        break;
      case "6":
        manager.loadEmployeeFromJSON();
        break;
      case "7":
      stdout.write("Exting program in progress..");
      return;
      default:
      stdout.write("\nWrong option, try again\n");
    }
  }
}