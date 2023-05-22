import 'package:app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';
import '../../database/models/ObjectModel.dart';
import '../../database/models/PlotModel.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../plot_screen/plot_screen.dart';
import '../globals.dart' as globals;

class Pair {
  final double a;
  final double b;

  Pair(this.a, this.b);
}

class AddPlotScreen extends StatefulWidget {
  final List<Pair> plotCoordinates;

  const AddPlotScreen(this.plotCoordinates, {super.key});
  @override
  State<AddPlotScreen> createState() => _AddPlotScreenState();
}

class _AddPlotScreenState extends State<AddPlotScreen> {
  final TextEditingController _textFieldController =
  TextEditingController(text: "");
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<PlotModel>(
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
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: const CustomIcon(iconData: Icons.save),
                        onPressed: () {
                          name = _textFieldController.text;
                          model.addPlot(name, nullImagePath);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()));
                        },
                      ),
                    ],
                  ),
                )
            )
        );
  }
}
