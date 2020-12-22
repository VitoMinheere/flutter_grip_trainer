import 'package:test/test.dart';
import 'package:grip_trainer/data/level.dart';

void main() {
  test('Updating seconds should complete level', () {
    var level =
        Level(categoryId: 1, number: 1, secondsToPass: 30, completed: false);
    expect(level.completed, false);
    print(level);

    // Level should not be completed
    level.updateSeconds(level.secondsToPass - 5);
    expect(level.completed, false);

    // Level should be completed
    level.updateSeconds(level.secondsToPass + 5);
    expect(level.completed, true);
  });
}
