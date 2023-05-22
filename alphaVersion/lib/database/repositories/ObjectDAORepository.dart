import 'package:get_it/get_it.dart';

import '../dao/object_dao.dart';
import '../entity/object.dart';

class ObjectDAORepository{

  late ObjectDAO _objectDao;

  ObjectDAORepository(){
    _objectDao = GetIt.instance.get<ObjectDAO>();
  }

  Future<void> addObject(MyObject object){
    return _objectDao.addObject(object);
  }

  Future<void> updateObject(MyObject object){
    return _objectDao.updateObject(object);
  }

  Future<List<MyObject>> findAllObjects(){
    return _objectDao.findAllObjects();
  }

  Stream<List<MyObject>> watchAllObjects(){
    return _objectDao.watchAllObjects();
  }

  Future<void> deleteObject(MyObject object){
    return _objectDao.deleteObject(object);
  }
}