import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/model/setlist.dart';

class SetListBloc {
  var _sets = SetList();

  final _additionController = StreamController<Set>();

  final _removalController = StreamController<Set>();

  final _replaceController = StreamController<Set>();

  final BehaviorSubject<List<Set>> _items = BehaviorSubject<List<Set>>();

  final BehaviorSubject<Set> _selectedSet = BehaviorSubject<Set>();

  Sink<Set> get addition => _additionController.sink;

  Sink<Set> get remove => _removalController.sink;

  Sink<Set> get replace => _replaceController.sink;

  Stream<List<Set>> get sets => _items.stream;

  Stream<Set> get selectedSet => _selectedSet.stream;

  SetListBloc() {
    _additionController.stream.listen((addition) {
      if (addition != null) {
        _sets.sets.add(addition);
        _items.add(_sets.sets);
      }
    });

    _removalController.stream.listen((removal) {
      if (removal != null) {
        _sets.sets.remove(removal);
        _items.add(_sets.sets);
      }
    });

    _replaceController.stream.listen((replace) {
      if (replace != null) {
        _sets.sets.insert(_sets.sets.indexOf(replace), replace);
        _items.add(_sets.sets);
        _selectedSet.add(replace);
      }
    });
  }
}
