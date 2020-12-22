import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'package:grip_trainer/data/category.dart';

void main() {
  test('Update levels complete only if not all levels are completed', () {
    var category = GripCategory(name: 'Test');
    category.setAmountOfLevels(10);
    expect(category.amountOfLevels, 10);

    // Complete 1 level
    category.setLevelsCompleted(1);
    expect(category.levelsCompleted, 1);

    // Complete too many levels. Should not update total
    category.setLevelsCompleted(20);
    expect(category.levelsCompleted, 1);

    // Complete all levels
    category.setLevelsCompleted(category.amountOfLevels);
    expect(category.levelsCompleted, category.amountOfLevels);
  });
}
