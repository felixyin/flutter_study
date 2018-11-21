void main() {
  print(add(1));
  print(add(2.2));

  FanXingService service = FanXingService<Dog>();
  Dog d = Dog("小黑");
  service.add(d);
  service.callFunc();
  service.remove(d);
}

// 方法范型
T add<T extends num>(T t) {
  return t + 1;
}

class Animal {
  final String name;

  Animal(this.name);

  void speak() {
    print("$name speak...");
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);
}

class FanXingService<T extends Animal> {
  final List<T> animalList = List<T>();

  void add(T value) => animalList.add(value);
  void remove(T value) => animalList.remove(value);

  void callFunc() {
    animalList.forEach((value) {
      value.speak();
    });
  }
}
