void main() {
//  已知类型
  int age = 0;
  print(age);

// 不可变的类型
  final height = 1.80;
  print(height.runtimeType);

//  未知、可变的类型
  var money = 100.32;
  print(money.runtimeType);

// 常量
  const score = 99.3;
  print(score);

  print(age + 33);
}
