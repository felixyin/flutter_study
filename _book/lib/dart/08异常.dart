void main() {
//  catchError();
//  raiseError(2, 5);
//  callRaiseError();

  callCarColor(Colors.black);
  callCarColor(Colors.blue);
}

catchError() {
  try {
    int a;
    double r = 100 / a;
    print(r);
  } catch (e) {
    print("错误: " + e.toString());
  }
}

raiseError(int a, int b) {
  try {
    if (a != b) throw Exception("a 不等于 b");
    print(a);
    print(b);
  } finally {
    print("done");
  }
}

callRaiseError() {
  try {
    raiseError(2, 5);
  } on Exception catch (e) {
    print(e.toString());
  }
}

class ColorException implements Exception {
  final String msg;

  ColorException(this.msg);

  @override
  String toString() {
    return this.msg;
  }
}

enum Colors { black, white, red, blue }

selectCarColor(Colors color) {
  if (color != Colors.black) {
    throw new ColorException("您没有选择黑色，错误!!");
  }
  print("您选择的颜色是: " + color.toString());
}

callCarColor(Colors color) {
  try {
    selectCarColor(color);
  } on ColorException catch (e) {
    print("Error: " + e.toString());
  } finally {
    print("done..");
  }
}
