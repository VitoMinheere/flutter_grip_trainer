class GripCategory {
  int id;
  String name;
  String image;
  int amountOfLevels;
  int levelsCompleted;

  GripCategory({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'image': image,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  GripCategory.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
  }

  void setAmountOfLevels(int levels) {
    this.amountOfLevels = levels;
  }

  void setLevelsCompleted(int completed) {
    if (completed <= this.amountOfLevels) {
      this.levelsCompleted = completed;
    }
  }
}
