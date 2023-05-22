import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/models/ObjectModel.dart';
import '../../database/models/PlotModel.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../home_screen/home_screen.dart';
import '../add_object_screen/add_object_screen.dart';
import '../globals.dart' as globals;
import '../object_screen/object_screen.dart';

class PlotScreen extends StatefulWidget {
  final int plotId;
  const PlotScreen(this.plotId, {super.key});

  @override
  State<PlotScreen> createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  _PlotScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,


        body: Center(
            child: Consumer<PlotModel>(
                  builder: (context, model, child) => Text (
                      "Obiekt działki ${model.plots[widget.plotId].plotName}"
                  )
              )
        ),



        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: const CustomIcon(iconData: Icons.arrow_back),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()
                        )
                    )
                ),
                IconButton(
                  icon: const CustomIcon(iconData: Icons.add_circle_outline_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddObjectScreen(widget.plotId)
                        )
                    );
                  },
                ),
                Consumer<ObjectModel>(
                    builder: (context, model, child) =>
                    PopupMenuButton(
                        icon: const CustomIcon(iconData: Icons.list),
                        itemBuilder: (context) {
                          List<PopupMenuItem> lst = <PopupMenuItem>[];
                          for(var i = 0; i < model.objects.length; i++){
                            if (model.objects[i].plotId == widget.plotId){
                              lst.add(PopupMenuItem(
                                  value: i,
                                  child: Text(model.objects[i].objectName)
                                )
                              );
                            }
                          }
                          return lst;
                        },
                        onSelected: (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ObjectScreen(objectId: value)
                              )
                          );
                        }
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
