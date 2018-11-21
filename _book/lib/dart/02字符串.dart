void main() {
  String s1 = ' this is s1 string   ';
  String s2 = " this is s2 string   ";
  String s3 = ''' this
  is 
  a 
  mutli 
  line string''';

  print(s1);
  print(s2);
  print(s3);

//  字符串拼接
  print("\n");
  print(s1 + "\t" + s2);

  print('$s1\t$s2');
  print("${s1}\t$s2");
  print('''${s1}\t$s2''');

  print(s1.trim());
}
