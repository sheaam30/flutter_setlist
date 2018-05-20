import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/model/setlist.dart';

class SetListBloc {
  SetList _sets = SetList();

  final _additionController = StreamController<Set>();

  final _removalController = StreamController<Set>();

  final _selectedSetController = StreamController<Set>();

  final BehaviorSubject<List<Set>> _items = BehaviorSubject<List<Set>>();

  final BehaviorSubject<Set> _selectedSet = BehaviorSubject<Set>();

  Sink<Set> get addition => _additionController.sink;

  Sink<Set> get remove => _removalController.sink;

  Sink<Set> get selected => _selectedSetController.sink;

  Stream<List<Set>> get sets => _items.stream;

  Stream<Set> get selectedSet => _selectedSet.stream;

  SetListBloc() {
    _additionController.stream.listen((addition) {
      if (addition != null) {
        _sets.addSet(addition);
        _items.add(_sets.sets);
      }
    });

    _removalController.stream.listen((removal) {
      if (removal != null) {
        _sets.removeSet(removal);
        _items.add(_sets.sets);
      }
    });

    _selectedSetController.stream.listen((selectedSet) {
      if (selectedSet != null) {
        _selectedSet.add(selectedSet);
      }
    });
  }
}
