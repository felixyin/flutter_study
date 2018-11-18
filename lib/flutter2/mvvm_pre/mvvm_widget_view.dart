import 'package:flutter/material.dart';
import './mvvm_widget_view_model.dart';
import './sample.dart';
  
class MvvmWidgetView extends MvvmWidgetViewModel {
    

  @override
  void initState() {
    super.initState();
    super.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http test'),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    if (super.isError) {
      return Center(
        child: Text(
          'error...',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    if (super.list.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: super.list.length,
        itemBuilder: (BuildContext context, int index) {
          Sample sample = super.list[index];
          return _buildListTile(sample, index);
        },
      );
    }
  }

  Column _buildListTile(Sample sample, int index) {
    List<Widget> _rows = <Widget>[
      ListTile(
        title: Text(sample.title),
        subtitle: Text(sample.body),
        trailing: Icon(Icons.launch),
        onTap: () {
          print(sample.userId);
        },
      ),
      Divider(),
    ];
    if (index == this.list.length - 1) {
      _rows.removeLast();
    }
    return Column(children: _rows);
  }
}

