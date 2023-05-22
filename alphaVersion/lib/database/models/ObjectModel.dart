import 'package:app/database/entity/object.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../repositories/ObjectDAORepository.dart';

class ObjectModel extends ChangeNotifier {

  late ObjectDAORepository _objectDAORepository;
  List<MyObject> objects = [];

  ObjectModel(){
    _objectDAORepository = GetIt.instance.get<ObjectDAORepository>();
    watchAllObjects();
  }

  void watchAllObjects(){
    _objectDAORepository.watchAllObjects().listen((objects) {
      this.objects = objects;
      print("!!!! I notify all listeners about objects bitch!");
      notifyListeners();
    });
  }

  Future<void> addObject(int plotId, String objectName, String color, String category, String notes) async {
    var newObject = MyObject(plotId: plotId, objectName: objectName, color:color, category:category, notes:notes);
    await _objectDAORepository.addObject(newObject);
  }

  Future<void> updateObject(MyObject object) async {
    await _objectDAORepository.updateObject(object);
  }

  Future<void> deleteObject(MyObject object) async {
    await _objectDAORepository.deleteObject(object);
  }

  Future<List<MyObject>> getObjects(){
    return _objectDAORepository.findAllObjects();
  }
}