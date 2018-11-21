void main() {
  String s = "啊,b,hello,java,"
      "c++,python,dart,node";

  print(s);

  List<String> list = s.split(",");
  print(list);
  assert(list.length == 8);
  print(list[0]);

  Map<String, int> whos = {
    "小明": 20,
    "小红": 21,
  };
  print(whos);
  print(whos.keys);
  print(whos.values);
}
