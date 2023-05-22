// CustomBottomAppBar bierze jako argumenty dwa przyciski
//TODO
//CustomBottomAppBar jako argument bierze liste przyciskow i tworzy z nich pasek
//Z kazdego ekranu mozna tworzyc wtedy CustomBottomAppBar ktory w calej aplikacji wyglada tak samo i mozna go łatwo edytować
//bo zmiana w klasie CustomBottomAppBar od razu zmieni wyglad całej aplikacji

import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    required this.iconButton,
    required this.iconButton2,
  });
  final IconButton iconButton;
  final IconButton iconButton2;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).bottomAppBarTheme.color,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          iconButton,
          iconButton2,
        ],
      ),
    );
  }
}
