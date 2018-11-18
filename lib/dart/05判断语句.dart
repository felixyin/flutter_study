void main() {
  if (10 > 9) {
    // 第一个匹配后续不会再执行
    print("10 > 9 is true");
  } else if (10 < 100) {
    print("10<100 is execute..");
  } else {
    print("other..");
  }

  print("\n\n");
  if (10 > 9) {
    // 第一个匹配后续不会再执行
    print("10 > 9 is true");
  }
  if (10 < 100) {
    print("10<100 is execute..");
  }
}
