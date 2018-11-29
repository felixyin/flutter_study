import 'package:flutter/material.dart';
import 'model_command.dart';

class ModelProvider extends InheritedWidget {
  ModelProvider({Key key, this.child, this.modelCommand}) : super(key: key, child: child);

  final Widget child;
  final ModelCommand modelCommand;

  @override
  bool updateShouldNotify(ModelProvider oldWidget) {
    return this.modelCommand != oldWidget.modelCommand;
  }

  static ModelProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ModelProvider) as ModelProvider);
  }
}
