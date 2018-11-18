void main() {
  int i = 0;
  while (i < 10) {
    print(i);
    i++;
  }

  print("\n");
  for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) continue;
    if (i % 7 == 0) break;
    print("hello $i");
  }

  print("\n");
  do {
    print(i);
    i--;
  } while (i >= 10);
}
