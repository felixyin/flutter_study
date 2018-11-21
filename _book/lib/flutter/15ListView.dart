import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: ExpandListView(),
  ));
}

class ExpandListView extends StatefulWidget {
  _ExpandListViewState createState() => _ExpandListViewState();
}

class _ExpandListViewState extends State<ExpandListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ExpandItem(datas[index]),
        itemCount: datas.length,
      ),
    );
  }
}

class ExpandItem extends StatelessWidget {
  final Entry entry;

  ExpandItem(this.entry);

  @override
  Widget build(BuildContext context) {
    return _buildItem(entry);
  }

  Widget _buildItem(Entry entry) {
    if (entry.items.isEmpty) {
      return ListTile(
        title: Text(entry.title),
      );
    } else {
      return ExpansionTile(
        key: new PageStorageKey<Entry>(entry),
        title: Text(entry.title),
        children: entry.items.map(_buildItem).toList(),
      );
    }
  }
}

class Entry {
  final String title;
  final List<Entry> items;

  Entry(this.title, [this.items = const <Entry>[]]);
}

List<Entry> datas = <Entry>[
  Entry(
    'Item A',
    <Entry>[
      Entry('Item A0'),
      Entry('Item A1'),
      Entry(
        'Item A2',
        <Entry>[
          Entry('Item A2.1'),
          Entry('Item A2.2'),
        ],
      ),
    ],
  ),
];

