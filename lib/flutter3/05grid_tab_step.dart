import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GridTabStep'),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                text: '面板',
              ),
              Tab(
                icon: Icon(Icons.time_to_leave),
                text: '步骤',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PanelPage(),
            StepPage(),
          ],
        ));
  }
}

class PanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 2.0,
      mainAxisSpacing: 2.0,
      scrollDirection: Axis.vertical,
      childAspectRatio: 1.0,
      children: <Widget>[
        _buildGridCard('主页', Icons.home),
        _buildGridCard('帮助', Icons.live_help),
        _buildGridCard('搜索', Icons.search),
        _buildGridCard('设置', Icons.settings),
        _buildGridCard('电影', Icons.theaters),
        _buildGridCard('音乐', Icons.music_note),
        _buildGridCard('工作', Icons.work),
        _buildGridCard('分享', Icons.share),
        _buildGridCard('主页', Icons.home),
        _buildGridCard('帮助', Icons.live_help),
        _buildGridCard('搜索', Icons.search),
        _buildGridCard('设置', Icons.settings),
        _buildGridCard('电影', Icons.theaters),
        _buildGridCard('音乐', Icons.music_note),
        _buildGridCard('工作', Icons.work),
        _buildGridCard('分享', Icons.share),
        _buildGridCard('主页', Icons.home),
        _buildGridCard('帮助', Icons.live_help),
        _buildGridCard('搜索', Icons.search),
        _buildGridCard('设置', Icons.settings),
        _buildGridCard('电影', Icons.theaters),
        _buildGridCard('音乐', Icons.music_note),
        _buildGridCard('工作', Icons.work),
        _buildGridCard('分享', Icons.share),
        _buildGridCard('主页', Icons.home),
        _buildGridCard('帮助', Icons.live_help),
        _buildGridCard('搜索', Icons.search),
        _buildGridCard('设置', Icons.settings),
        _buildGridCard('电影', Icons.theaters),
        _buildGridCard('音乐', Icons.music_note),
        _buildGridCard('工作', Icons.work),
        _buildGridCard('分享', Icons.share),




      ],
    );
  }

  int colorIndex = 0;
  Card _buildGridCard(String title, IconData iconData) {
    List<Color> colorList = Colors.accents;
    colorIndex = colorIndex % colorList.length;
    Color seqColor = colorList[colorIndex++];

    return Card(
      elevation: 3.0,
      color: seqColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(
              iconData,
              color: Colors.black38,
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StepPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StepPageState();
  }
}

class _StepPageState extends State<StepPage> with SingleTickerProviderStateMixin{
  int _currentStep = 0;
  List<Step> _stepList = <Step>[
    Step(title: Text('步骤1'), content: Text('这里是步骤1的内容。'), isActive: true),
    Step(
        title: Text('步骤2'),
        subtitle: Text('说明，这里需要审批'),
        content: Text('这里是步骤2的内容。'),
        isActive: true),
    Step(title: Text('步骤3'), content: Text('这里是步骤3的内容。'), isActive: true),
    Step(title: Text('步骤4'), content: Text('这里是步骤4的内容。'), isActive: true),
  ];
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    final Animation<double> animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeInOut,
    );
    animation.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: this._stepList,
        currentStep: this._currentStep,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          List<Widget> _widgetList = <Widget>[
            FlatButton(
              color: Colors.lightBlueAccent[200],
              onPressed: onStepContinue,
              child: const Text('下一步'),
            ),
            FlatButton(
              color: Colors.redAccent[200],
              onPressed: onStepCancel,
              child: const Text('上一步'),
            ),
          ];
          if (this._currentStep == 0) {
            _widgetList.removeLast();
          } else if (this._currentStep == this._stepList.length - 1) {
            _widgetList.removeAt(0);
            _widgetList.insert(
                0,
                FlatButton(
                  color: Colors.lightBlueAccent[200],
                  onPressed: this._onStepFinish,
                  child: const Text('完成'),
                ));
          }

          return Transform.scale(
            scale: _animationController.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _widgetList,
            ),
          );
        },
        onStepTapped: (step) {
          _animationController
            ..reset()
            ..forward();
          setState(() {
            this._currentStep = step;
          });
        },
        onStepContinue: () {
          if (this._currentStep < this._stepList.length - 1) {
            setState(() {
              this._currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (this._currentStep > 0) {
            setState(() {
              this._currentStep -= 1;
            });
          }
        },
      ),
    );
  }

  void _onStepFinish() {
    print('finish ....');
  }
}
