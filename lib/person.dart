class Person {
  String name;
  int age;

  Person(this.name,this.age);

  // This displayInfo will be overriden. it should be printed in Main but cuz it will be overridden then nothing will happen
  // And how it works? it will be changed in "employee.dart" then the final thing will be printed in Main
  void displayInfo(){
    print("Name is: $name Age is:$age");
  }
}