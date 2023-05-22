import 'package:app/database/entity/plot.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@dao
abstract class PlotDAO extends ChangeNotifier {
  @insert
  Future<void> addPlot(MyPlot plot);

  @update
  Future<void> updatePlot(MyPlot plot);

  @Query('SELECT * FROM MyPlot')
  Future<List<MyPlot>> findAllPlots();

  @Query('SELECT * FROM MyPlot')
  Stream<List<MyPlot>> watchAllPlots();

  @delete
  Future<void> deletePlot(MyPlot plot);
}
