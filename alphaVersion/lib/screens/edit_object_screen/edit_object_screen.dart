import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import '../../database/models/ObjectModel.dart';
import '../../database/models/PlotModel.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../plot_screen/plot_screen.dart';
import '../globals.dart' as globals;
import '../../database/entity/object.dart';

class EditObjectScreen extends StatefulWidget {
  int objectId;
  int plotId;
  String name;
  String color;
  String category;
  String notes;

  EditObjectScreen(this.objectId, this.name, this.color, this.category, this.notes, this.plotId, {super.key});
  
  @override
  State<EditObjectScreen> createState() => _EditObjectScreenState();
}

class _EditObjectScreenState extends State<EditObjectScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  @override
  void initState(){
    super.initState();
    nameController = new TextEditingController(text: widget.name);
    colorController = new TextEditingController(text: widget.color);
    categoryController = new TextEditingController(text: widget.category);
    notesController = new TextEditingController(text: widget.notes);
    }
  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectModel>(
        builder: (context, model, child) => Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text(
                        "Nazwa obiektu:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nazwa',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                  ))
                  ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text(
                        "Kolor:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: colorController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nazwa',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                  ))
                  ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text(
                        "Kategoria:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nazwa',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                  ))
                  ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Text(
                        "Notatki:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nazwa',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                  ))
                  ]),
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
                    var object = model.objects[widget.objectId];
                    object.objectName = nameController.text;
                    object.color = colorController.text;
                    object.category = categoryController.text;
                    object.notes = notesController.text;
                    model.updateObject(object);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        )
    );
  }
}
