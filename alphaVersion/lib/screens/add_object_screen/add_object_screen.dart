import 'package:provider/provider.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';
import '../../database/models/ObjectModel.dart';
import '../../database/models/PlotModel.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../plot_screen/plot_screen.dart';
import '../globals.dart' as globals;

class AddObjectScreen extends StatefulWidget {
  int plotId;

  AddObjectScreen(this.plotId, {super.key});
  @override
  State<AddObjectScreen> createState() => _AddObjectScreenState();
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  final TextEditingController _textFieldController =
      TextEditingController(text: "");
  final TextEditingController _textFieldController2 =
      TextEditingController(text: "");
  final TextEditingController _textFieldController3 =
      TextEditingController(text: "");
  final TextEditingController _textFieldController4 =
      TextEditingController(text: "");
  String name = "";
  String color = "";
  String category = "";
  String notes = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectModel>(
        builder: (context, model, child) => Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nazwa',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _textFieldController2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kolor',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _textFieldController3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kategoria',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _textFieldController4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Notatki',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ]),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).bottomAppBarTheme.color,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                  IconButton(
                  icon: const CustomIcon(iconData: Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlotScreen(widget.plotId)));
                  },
                ),
                IconButton(
                  icon: const CustomIcon(iconData: Icons.save),
                  onPressed: () {
                    name = _textFieldController.text;
                    color = _textFieldController2.text;
                    category = _textFieldController3.text;
                    notes = _textFieldController4.text;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlotScreen(widget.plotId)));
                    model.addObject(widget.plotId, name, color, category,notes);
                  },
                ),
              ],
            ),
          )
        )
    );
  }
}
