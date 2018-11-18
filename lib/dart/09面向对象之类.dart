void main() {
  Animal a1 = Animal(name: "小猪", age: 3, weight: 20.3);
  a1.eat();

  Dog d1 = Dog(name: "旺财", age: 2, weight: 9.28, color: "black");
  d1.bark();
  print(d1.sleep());
  Dog d2 = Dog(name: "旺财", age: 2, weight: 9.28);
  d2.bark();
}

class Animal {
  final double weight;
  final int age;
  final String name;
  Animal({this.age, this.name, this.weight});

  eat() {
    print("$name,吃...");
  }

  sleep() {
    print("$name,睡...");
  }
}

class Dog extends Animal {
  final String color;

  Dog({int age, String name, double weight, this.color = "white"})
      : super(name: name, age: age, weight: weight);

  @override
  String sleep() {
    // 覆盖方法，方法签名与返回值无关。。？？
    return "$name，睡了一下午...";
  }

  void bark() {
    print("小狗$name在叫，他的体重是$weight,颜色是$color");
  }
}
