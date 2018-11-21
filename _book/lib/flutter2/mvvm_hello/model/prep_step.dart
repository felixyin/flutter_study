class PrepStep {
  static int id = 1;

  String name;
  String shortDescription;
  String longDescription;
  int number;
  bool isFinished;

  PrepStep() {
    this.shortDescription = 'This is a very short description of the Step';
    this.longDescription =
        'This is a slightly longer description of the Step. Detailed instructions go here.';
    this.number = id++;
    this.isFinished = false;
    this.name = 'Step ${this.number}';
  }

  String getDueDays() {
    if (this.number == 1) {
      return '1 Day';
    } else {
      return '${this.number} Days';
    }
  }
}