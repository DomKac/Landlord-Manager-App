import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

import '../entity/object.dart';

@dao
abstract class ObjectDAO extends ChangeNotifier {
  @insert
  Future<void> addObject(MyObject object);

  @update
  Future<void> updateObject(MyObject object);

  @Query('SELECT * FROM MyObject')
  Future<List<MyObject>> findAllObjects();

  @Query('SELECT * FROM MyObject')
  Stream<List<MyObject>> watchAllObjects();

  @delete
  Future<void> deleteObject(MyObject object);
}
