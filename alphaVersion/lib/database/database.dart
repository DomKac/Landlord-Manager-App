import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/object_dao.dart';
import 'dao/plot_dao.dart';
import 'entity/object.dart';
import 'entity/plot.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [MyPlot, MyObject])
abstract class AppDatabase extends FloorDatabase {
  PlotDAO get plotDao;
  ObjectDAO get objectDao;
}
