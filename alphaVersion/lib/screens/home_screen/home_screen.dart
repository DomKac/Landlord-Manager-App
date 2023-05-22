import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../database/models/PlotModel.dart';
import '../../reusable_widgets/custom_icon.dart';
import '../globals.dart' as globals;
import '../plot_screen/plot_screen.dart';
import 'custom_appbar.dart';
import 'home_screen_plot_search.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:app/screens/plot_drawer_screen/goomap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;



  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Check Location Permissions, and get my location
  void _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  String plotName = "";
  @override
  Widget build(BuildContext context) {
    double? heightOfImages = 200;
    double? widthOfImages = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: Consumer<PlotModel>(
          builder: (context, model, child) => ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>  const Divider(),
            itemCount: model.plots.length,
            itemBuilder: (BuildContext context, int index) {
              var item = model.plots[index];
              return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    model.deletePlot(item);
                    setState(() {});
                  },
                  background: Container(color: Colors.red),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PlotScreen(index)));
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    changeName(context, item.plotName).then((onValue){
                                      if(item.plotName != plotName) {
                                        plotName = "";
                                        item.plotName = onValue;
                                        model.updatePlot(item);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                              (Route<dynamic> route) => false,
                                        );
                                      }
                                    });
                                  }),
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color?>(Theme.of(context).iconTheme.color),
                                ),
                                child: const Icon(Icons.create_outlined),
                              ),
                              title: Text(model.plots[index].plotName),

                              trailing: Wrap(
                                spacing: 0,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () => {
                                      pickImage(model,index),
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color?>(Theme.of(context).iconTheme.color),
                                    ),
                                    child: const Icon(Icons.camera_alt),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      setState(() {
                                        deletePhoto(context, index, model).then((onValue){
                                          if(item.imagePath == nullImagePath) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()),
                                                  (Route<
                                                  dynamic> route) => false,
                                            );
                                          }
                                        });
                                      }),
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color?>(Theme.of(context).iconTheme.color),
                                    ),
                                    child: const Icon(Icons.no_photography),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            model.plots[index].imagePath != nullImagePath  ?
                            SizedBox(
                                height: heightOfImages,
                                width: widthOfImages,
                                child:
                                Image.file(
                                  File(model.plots[index].imagePath),
                                  fit: BoxFit.cover,
                                )

                            ) : const SizedBox( height: 0, width: 0),
                          ],
                        ),
                      )));
            }
        ),),
        bottomNavigationBar: CustomBottomAppBar(
          iconButton: IconButton(
              icon: const CustomIcon(
                iconData: Icons.add_circle_outline,
              ),
              onPressed: () => _locationData != null ? Navigator.push(
                  context, MaterialPageRoute(builder: (context) => GooMap(location: _locationData,))) : null
          ),
          iconButton2: IconButton(
            icon: const CustomIcon(
              iconData: Icons.search,
            ),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
        )
    );
  }

  Future<String> changeName(BuildContext context, object){
    String newName = object;
    String oldName = object;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Nazwa: "),
            content:
            TextFormField(
              initialValue: object,
              onChanged: (value) {
                setState(() {
                  newName = value;
                });
              },
            ),
            actions: [
              TextButton(
                child: const Text("Anuluj"),
                onPressed: () {
                  plotName = oldName;
                  Navigator.of(context).pop(oldName);
                },
              ),
              TextButton(
                child: Text("Zapisz"),
                onPressed: () {
                  if(newName != "") {
                    plotName = newName;
                    Navigator.of(context).pop(newName);
                  }
                },
              )
            ]
        );
      },).then((value) => value ?? "");
  }

  Future<XFile> deletePhoto(BuildContext context, index, PlotModel model){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Czy na pewno chcesz usunąć zdjęcie?"),
            actions: [
              TextButton(
                child: const Text("Nie"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Tak"),
                onPressed: () {
                  model.plots[index].imagePath = nullImagePath;
                  model.updatePlot(model.plots[index]);
                  Navigator.pop(context);
                },
              )
            ]
        );
      },).then((value) => value ?? model.plots[index].imagePath);
  }

  Future pickImage(PlotModel model, index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState((){
        model.plots[index].imagePath = image.path;
        model.updatePlot(model.plots[index]);
      });
    } on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }
}