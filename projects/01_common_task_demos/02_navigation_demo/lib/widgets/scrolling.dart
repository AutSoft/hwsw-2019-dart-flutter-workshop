import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget scrolling() {
  return Container(
    margin: const EdgeInsets.only(left: 12, right: 12),
    child: Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, -0.01)
        ..rotateX(0.1)
      ..translate(0.0, 0.0, 10.0),
      alignment: FractionalOffset.center,
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                stops: [0.0, 0.2],
                colors: [Colors.black, Colors.transparent])
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image(
                image: NetworkImage(
                    "https://cdn.theatlantic.com/assets/media/img/mt/2019/11/mandalorian/lead_720_405.jpg?mod=1573575214"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 400),
                child: Text(review),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String review =
    '''You can take Star Wars out of the movie theater, but you can’t take the television out of television. That was my first impression on seeing The Mandalorian, the expensive-looking new show that is the marquee offering of the Disney+ streaming service. There have been TV forays into George Lucas’s sci-fi universe before, in the form of much-maligned holiday specials and animated programs aimed at young audiences. But the first episode of The Mandalorian, which dropped today, looks like it could be the first act of a blockbuster film, laden with elaborate alien creatures, blaster shoot-outs, and dazzling set design.

The impressive production values, however, can’t cover up a relatively skimpy plot. “Chapter 1” of The Mandalorian is a thin piece of setup stretched over 38 minutes, barely introducing its hero and then dangling a tantalizing twist at the end. The narrative flimsiness is a sign that, despite the studio’s financial resources and the imperative to make this TV debut feel like a major event, Disney+ is following the No. 1 rule of streaming as first defined by Netflix: Dragging out one story over the course of a whole season is the best way to hook subscribers.

Unlike most Netflix shows, episodes of The Mandalorian will be released weekly, with the next installment due out Friday and then six more planned for the rest of the year. After that, the series will exist, eternally binge-ready, in a corner of Disney’s library—a small part of the company’s plan for digital domination that includes various Marvel spin-offs and an archive of cinema classics. The Mandalorian’s pilot episode is a distillation of that plan. It’s a handsome-looking work of marginalia that’s embedded within the Star Wars universe but that doesn’t interfere with the films’ main saga.

The show’s creator is Jon Favreau, a Disney mainstay who has directed two Iron Man movies along with The Jungle Book and The Lion King. (He’s also an avowed Star Wars fan who made a voice appearance in the recent spin-off Solo.) The series is indebted to old Westerns, with the laser-gun-toting, armor-clad Mandalorian (played by Pedro Pascal, though we never see his face) giving off a distinct “Man With No Name” vibe. Wearing a costume reminiscent of the hallowed character Boba Fett (another bounty hunter from the planet Mandalore), the Mandalorian travels the galaxy looking for fugitives and lowlifes, hauling them in for justice and a paltry sum.
''';
