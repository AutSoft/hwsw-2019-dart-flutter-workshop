import 'package:flutter/widgets.dart';

import 'main_bloc.dart';

class StateHolderInheritedWidget extends InheritedWidget {
  final MainBloc bloc;

  StateHolderInheritedWidget({
    Key key,
    this.bloc,
    @required Widget child
  }): super(key: key, child: child);

  static StateHolderInheritedWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(StateHolderInheritedWidget);
  }

  @override
  bool updateShouldNotify(StateHolderInheritedWidget oldWidget) {
    return bloc != oldWidget.bloc;
  }


}
