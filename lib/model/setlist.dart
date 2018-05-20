import 'package:scoped_model/scoped_model.dart';
import 'package:setlist/model/set.dart';

class SetList extends Model {
  var sets = List<Set>();

  SetList();

  Set getIndex(int index) {
    return sets[index];
  }

  void addSet(Set set) {
    sets.add(set);
  }

  void removeSet(Set set) {
    sets.remove(set);
  }
}
