import 'dart:async';
import 'dart:math';

Future<bool> testAsync(String prefix) async {
  await Future.delayed(Duration(seconds: Random().nextInt(4)));
  for (int i = 0; i < 5; i++) {
    print('$prefix $i');
  }
  return true;
}

Future callTestAsync() async {
  print('starting');
  /*await */ testAsync('async');
  print('done');
}

void callTestThen() {
  print('starting');
  testAsync("then").then((v) {
    print('done watting: $v');
  });
  print('done');
}

void callTestWait() async {
  print('starting');
  bool b = await testAsync('async');
  print('done: $b');
}

void callTestChain() async {
  print('starting');
  Future f1 = testAsync('chain1');
  Future f2 = testAsync('chain2');
  Future f3 = testAsync('chain3');
  await Future.any([f1, f2, f3]);
  print('done..');
}

void main(List<String> args) {
//  callTestAsync();
//  callTestThen();
//  callTestWait();
  callTestChain();
}
