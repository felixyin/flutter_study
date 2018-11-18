import '../model/prep_step_list.dart';
import '../view_model/prep_step_view_model.dart';

class PrepStepListViewModel {
  PrepStepList prepStepList;
  List<PrepStepViewModel> prepStepViewModels;

  PrepStepListViewModel({prepStepList}) {
    this.prepStepViewModels = new List();

    this.prepStepList = prepStepList;
    if (this.prepStepList != null) {
      for (int index = 0; index < this.prepStepList.prepSteps.length; index++) {
        prepStepViewModels
            .add(PrepStepViewModel(step: this.prepStepList.prepSteps[index]));
      }
    }
  }
}
