import 'dart:io';
import 'dart:convert';

void listFiles(String path) {
  try {
    Directory dir = Directory(path);
    List<FileSystemEntity> list = dir.listSync();
    list.forEach((f) {
      print(f.path);
    });
  } catch (e) {
    print(e);
  }
}

void writeFile(String path, String data, FileMode mode) {
  RandomAccessFile openWrite;
  try {
    File f = File(path);
    if (!f.existsSync()) f.createSync();
//    openWrite = f.openSync(mode: mode);
//    openWrite.writeStringSync(data);
//    openWrite.flushSync();
    openWrite = f.openSync(mode: mode)
      ..writeStringSync(data)
      ..flushSync();
  } catch (e) {
    print(e.toString());
  } finally {
    openWrite.closeSync();
  }
}

String readFile(String path, FileMode mode) {
  try {
    File f = File(path);
    return f.readAsStringSync();
  } catch (e) {
    print(e.toString());
  }
  return '';
}

void writeJson(String path) {
  Map<String, Object> map = {};
  map.putIfAbsent('name', () => '张三');
  map.putIfAbsent('age', () => 22);
  map.putIfAbsent('sex', () => '男');

  String data = json.encode(map);
  writeFile(path, data, FileMode.write);
}

void readJson(String path) {
  String jsonStr = readFile(path, FileMode.read);
  Map<String, Object> map = json.decode(jsonStr);
  map.forEach((String k, Object v) {
    print(k + ":" + v.toString());
  });
}

void main() {
  listFiles('/Users/fy/temp/startup_namer/lib/dart');

  String path = '/Users/fy/temp/startup_namer/lib/dart/test_file.txt';
  writeFile(path, "hello world", FileMode.write);

  String content = readFile(path, FileMode.read);
  print(content);

  path = '/Users/fy/temp/startup_namer/lib/dart/test_json.json';
  writeJson(path);
  readJson(path);
}
