import 'dart:collection';
import 'package:app/screens/add_plot_screen/add_plot_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../database/models/PlotModel.dart';
import '../globals.dart' as globals;
import '../home_screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../reusable_widgets/custom_icon.dart';

class GooMap extends StatefulWidget {
  //GooMap({Key key}) : super(key: key);

  final LocationData location;
  GooMap({required this.location});

  @override
  _GooMapState createState() => _GooMapState();
}

class _GooMapState extends State<GooMap> {
  // Location
  late LocationData _locationData;
  String codeDialog = "";
  String valueText = "";
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
                title: const Text('Podaj nazwę działki'),
                content: TextField(
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "Nazwa działki"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Anuluj'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  Consumer<PlotModel>(
                      builder: (context, model, child) =>TextButton(
                        child: const Text('Zapisz'),
                        onPressed: () {
                          if(valueText != "") {
                            model.addPlot(valueText, nullImagePath);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()));
                          }
                        },
                      )),
                ],
          );
        });
  }



  static Future<XFile> get getFile async {
    return XFile('assets/images/null_image.png');
  }

  // Maps
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circles = HashSet<Circle>();
  late GoogleMapController _googleMapController;
  late BitmapDescriptor _markerIcon;
  List<LatLng> polygonLatLngs = <LatLng>[]; //lista wspolrzednych punktów poligona
  late double radius;

  //ids
  int _polygonIdCounter = 1;
  int _circleIdCounter = 1;
  int _markerIdCounter = 1;

  // Type controllers
  bool _isPolygon = true; //Default
  bool _isMarker = false;
  bool _isCircle = false;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
    _locationData = widget.location;
  }

  // This function is to change the marker icon
  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/farm.png');
  }

  // Draw Polygon to the map
  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs, //lista punktów dodanych przez tap
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    ));
  }

  // Set circles as points to the map
  void _setCircles(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    print(
        'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $radius');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: radius,
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  // Start the map with this marker setted up
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(-20.131886, -47.484488),
          infoWindow:
          InfoWindow(title: 'Roça', snippet: 'Um bom lugar para estar'),
          //icon: _markerIcon,
        ),
      );
    });
  }

  Widget _fabPolygon() {
    return FloatingActionButton.extended(
      onPressed: () {
        //Remove the last point setted at the polygon
        setState(() {
          polygonLatLngs.removeLast();
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Undo point'),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).bottomAppBarTheme.color,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                  child: const Text(
                    'Anuluj',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context)),
              InkWell(
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 50,
                    child: const Center(child: Text('ZAPISZ')),
                  ),
                  onTap: () {
                    List<Pair> cords = [Pair(1.2, 3.4)];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlotScreen(cords)
                        )
                    );
                  }),
              IconButton(
                  icon: const CustomIcon(iconData: Icons.undo_outlined),
                  alignment: FractionalOffset.bottomRight,
                  onPressed: () {
                    if(_isPolygon && polygonLatLngs.isNotEmpty){
                      setState(() {
                        polygonLatLngs.removeLast();
                      });
                    }
                    //
                  })
            ],
          ),
        ),
        // floatingActionButton:
        // polygonLatLngs.length > 0 && _isPolygon ? _fabPolygon() : null,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_locationData.latitude! , _locationData.longitude!),
                zoom: 16,
              ),
              mapType: MapType.hybrid,
              markers: _markers,
              circles: _circles,
              polygons: _polygons,
              myLocationEnabled: true,
              onTap: (point) { //co sie dzieje gdy klikam
                if (_isPolygon) {
                  setState(() {
                    polygonLatLngs.add(point); //dodaje punkt z mapy
                    _setPolygon(); //rysuje na podstawie punktów
                  });
                } else if (_isMarker) {
                  setState(() {
                    _markers.clear();
                    _setMarkers(point);
                  });
                } else if (_isCircle) {
                  setState(() {
                    _circles.clear();
                    _setCircles(point);
                  });
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    //color: Colors.black54,
                      onPressed: () {
                        _isPolygon = true;
                        _isMarker = false;
                        _isCircle = false;
                      },
                      child: Text(
                        'Polygon',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  ElevatedButton(
                    //color: Colors.black54,
                      onPressed: () {
                        _isPolygon = false;
                        _isMarker = true;
                        _isCircle = false;
                      },
                      child: Text('Marker',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  // ElevatedButton(
                  //     //color: Colors.black54,
                  //     onPressed: () {
                  //       _isPolygon = false;
                  //       _isMarker = false;
                  //       _isCircle = true;
                  //       radius = 50;
                  //       return showDialog(
                  //           context: context,
                  //           child: AlertDialog(
                  //             backgroundColor: Colors.grey[900],
                  //             title: Text(
                  //               'Choose the radius (m)',
                  //               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  //             ),
                  //             content: Padding(
                  //                 padding: EdgeInsets.all(8),
                  //                 child: Material(
                  //                   color: Colors.black,
                  //                   child: TextField(
                  //                     style: TextStyle(fontSize: 16, color: Colors.white),
                  //                     decoration: InputDecoration(
                  //                       icon: Icon(Icons.zoom_out_map),
                  //                       hintText: 'Ex: 100',
                  //                       suffixText: 'meters',
                  //                     ),
                  //                     keyboardType:
                  //                     TextInputType.numberWithOptions(),
                  //                     onChanged: (input) {
                  //                       setState(() {
                  //                         radius = double.parse(input);
                  //                       });
                  //                     },
                  //                   ),
                  //                 )),
                  //             actions: <Widget>[
                  //               FlatButton(
                  //                   onPressed: () => Navigator.pop(context),
                  //                   child: Text(
                  //                     'Ok',
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,),
                  //                   )),
                  //             ],
                  //           ));
                  //     },
                  //     child: Text('Circle',
                  //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
                ],
              ),
            )
          ],
        ));
  }
}