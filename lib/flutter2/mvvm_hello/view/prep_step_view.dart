import 'package:flutter/material.dart';
import '../view_model/prep_step_view_model.dart';

class PrepStepView extends StatefulWidget {
  PrepStepViewModel stepViewModel;

  PrepStepView({stepViewModel}) {
    this.stepViewModel = stepViewModel;
  }

  @override
  _PrepStepViewState createState() => _PrepStepViewState();
}

class _PrepStepViewState extends State<PrepStepView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(this.widget.stepViewModel.step.name),
            subtitle: Text(
              'Step ${this.widget.stepViewModel.step.number.toString().padLeft(2, '0')}'
                  '- Due in ${this.widget.stepViewModel.step.getDueDays()}',
            ),
            trailing: Checkbox(
              value: this.widget.stepViewModel.step.isFinished,
              onChanged: onCheckBoxChanged,
              tristate: true,
            ),
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(this.widget.stepViewModel.step.shortDescription),
            subtitle: Text('Description'),
          )
        ],
      ),
    );
  }

  void onCheckBoxChanged(bool value) {
    setState(() {
      this.widget.stepViewModel.step.isFinished = value;
    });
  }
}
