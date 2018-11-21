import 'package:flutter/material.dart';
import 'model/prep_step_list.dart';
import 'view/prep_step_list_view.dart';
import 'model/prep_step.dart';
import 'view_model/prep_step_list_view_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Itinerary',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new ItineraryApp(),
    );
  }
}

class ItineraryApp extends StatefulWidget {
  ItineraryApp() {}

  @override
  _ItineraryAppState createState() => _ItineraryAppState();
}

class _ItineraryAppState extends State<ItineraryApp> {
  List<PrepStep> prepSteps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary'),
      ),
      body: PrepStepListView(
        prepStepListViewModel: PrepStepListViewModel(
          prepStepList: PrepStepList(
            prepSteps: prepSteps,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    prepSteps = new List<PrepStep>();
    for (int counter = 0; counter < 30; counter++) {
      PrepStep step = new PrepStep();
      this.prepSteps.add(step);
    }
  }
}
