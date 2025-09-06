class Person {
  String name;    // Req1 from the PDF: name (String) 
  int age;       // Req2 from the PDF: age (int)

  Person(this.name,this.age);   // Req3 from the PDF: constructor

  // This displayInfo will be overriden. it should be printed in Main but cuz it will be overridden then nothing will happen
  // And how it works? it will be changed in "employee.dart" then the final thing will be printed in Main
  void displayInfo(){          // Req4 from the PDF: displayInfo() method
    print("Name is: $name Age is:$age");
  }
}