import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:setlist/model/set.dart';
import 'package:setlist/model/setlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getSetList();
    _additionController.stream.listen((addition) {
      if (addition != null) {
        _sets.addSet(addition);
        _items.add(_sets.sets);

        updateSetList(_sets.toJson());
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

  Future<SetList> getSetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var setListJson = prefs.getString("setListKey");
    new SetList.fromJson(setListJson);
  }

  updateSetList(Map setList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("setListKey", setList.toString());
  }

  void dispose() {
    selected.close();
    addition.close();
    remove.close();
  }
}
