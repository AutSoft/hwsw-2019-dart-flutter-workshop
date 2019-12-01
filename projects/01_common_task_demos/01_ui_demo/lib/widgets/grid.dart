import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget grid(List<MaterialColor> items) {
  return GridView.builder(
    itemCount: items.length * 2,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (context, index) {
      return
        Card(
          child: Material(
          color: items[index % (items.length)],
          child: InkWell(
            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Item $index clicked!"),
            )),
          ),
      ),
        );
    },
  );
}
