import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main_page_events.dart';
import '../state_holder_inherited_widget.dart';


class MainControls extends StatelessWidget {
  
  MainControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StateHolderInheritedWidget.of(context).bloc;
    
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => bloc.eventSink.add(ColderEvent()),
            tooltip: 'Colder',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventSink.add(WarmerEvent()),
            tooltip: 'Warmer',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
