import 'package:flutter/material.dart';
import 'package:setlist/bloc/setlistbloc.dart';

class SetListProvider extends InheritedWidget {
  final SetListBloc setListBloc;

  SetListProvider({
    Key key,
    SetListBloc setListBloc,
    Widget child,
  })  : setListBloc = setListBloc ?? SetListBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SetListBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SetListProvider) as SetListProvider)
          .setListBloc;
}
