void main() {
  eat();
  print(getMoney());

  print(eat3("西红柿"));
  print(eat4("馒头", "西红柿"));
  print(eat4("馒头", "西红柿", "苹果"));

  print(eat5("你", fuShi: "剁椒鱼头", shuiGuo: "葡萄", zhuShi: "米饭"));
}

void eat() {
  // 无返回值，void
  print("I am eating");
}

double getMoney() {
  return 800.10; // 返回
}

//省略返回值：String，省略return语句，=>后面是表达式
eat2(String food) => "I am eat $food";

var eat3 = eat2; // 可赋值

//可选参数
String eat4(String zhuShi, String fuShi, [String shuiGuo]) {
  return "我的主食是：$zhuShi，辅食是$fuShi，水果是$shuiGuo";
}

// 可选命名参数
String eat5(String who, {String zhuShi, String fuShi, String shuiGuo}) {
  return "$who的主食是：$zhuShi，辅食是$fuShi，水果是$shuiGuo";
}
