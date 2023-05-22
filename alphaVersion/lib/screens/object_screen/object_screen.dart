import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import '../../database/models/ObjectModel.dart';
import 'package:provider/provider.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../../database/models/ObjectModel.dart';
import '../../database/entity/object.dart';
import '../edit_object_screen/edit_object_screen.dart';

class ObjectScreen extends StatelessWidget {
  ObjectScreen({super.key, required this.objectId});
  final int objectId;
  //TODO ObjectScreen takes object as parameter and extracts all necessery things as name, color, image,
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<ObjectModel>(
        builder: (context, model, child) => Column(
        children: [
          ObjectScreenBodyTitle(name: model.objects[objectId].objectName, size: size),
          ObjectScreenCategoryBox(category: model.objects[objectId].category, size: size),
          ObjectScreenColorBox(size: size, color: Colors.grey),
          ObjectScreenNotesBox(size: size, notes: model.objects[objectId].notes),
          /*Image.asset(
            "assets/images/image.png",
            fit: BoxFit.fitWidth,
          ),*/
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Consumer<ObjectModel>(
          builder: (context, model, child) =>  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const CustomIcon(iconData: Icons.arrow_back),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditObjectScreen(objectId, 
                            model.objects[objectId].objectName, 
                            model.objects[objectId].color,
                            model.objects[objectId].category,
                            model.objects[objectId].notes,
                            model.objects[objectId].plotId)
                        )
                    );
                },
                icon: const CustomIcon(iconData: Icons.edit),
                iconSize: size.height * 0.05,
              ),
              IconButton(
                onPressed: () {
                  model.deleteObject(model.objects[objectId]);
                  Navigator.pop(context);
                  },
                icon: const CustomIcon(iconData: Icons.delete),
                iconSize: size.height * 0.05,
              ),
            ],
          ))),
    );
  }
}

class ObjectScreenNotesBox extends StatelessWidget {
  const ObjectScreenNotesBox({
    super.key,
    required this.size,
    required this.notes,
  });

  final Size size;
  final String notes;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.20,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: size.width * 0.3,
              child: Text(
                "Notatki:",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  notes,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    color: AppBackgroundColor,
                    boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1)]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ObjectScreenColorBox extends StatelessWidget {
  const ObjectScreenColorBox({
    super.key,
    required this.size,
    required this.color,
  });

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.10,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: size.width * 0.3,
              child: Text(
                "Color:",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: color,
                    boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1)]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ObjectScreenCategoryBox extends StatelessWidget {
  const ObjectScreenCategoryBox({
    super.key,
    required this.category,
    required this.size,
  });

  final Size size;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.10,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: size.width * 0.3,
              child: Text(
                "Kategoria:",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    color: AppBackgroundColor,
                    boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1)]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ObjectScreenBodyTitle extends StatelessWidget {
  const ObjectScreenBodyTitle({
    super.key,
    required this.size,
    required this.name,
  });
  final String name;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.12,
        width: size.width,
        child: Text(
          name,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(color: AppBackgroundColor, boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: Offset.zero,
              blurRadius: 2,
              spreadRadius: 2,
              blurStyle: BlurStyle.normal)
        ]),
      ),
    );
  }
}
