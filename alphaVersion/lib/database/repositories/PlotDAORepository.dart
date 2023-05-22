import 'package:get_it/get_it.dart';

import '../dao/plot_dao.dart';
import '../entity/plot.dart';

class PlotDAORepository{

  late PlotDAO _plotDao;

  PlotDAORepository(){
    _plotDao = GetIt.instance.get<PlotDAO>();
  }

  Future<void> addPlot(MyPlot plot){
    return _plotDao.addPlot(plot);
  }

  Future<void> updatePlot(MyPlot plot){
    return _plotDao.updatePlot(plot);
  }

  Future<List<MyPlot>> findAllPlots(){
    return _plotDao.findAllPlots();
  }

  Stream<List<MyPlot>> watchAllPlots(){
    return _plotDao.watchAllPlots();
  }

  Future<void> deletePlot(MyPlot plot){
    return _plotDao.deletePlot(plot);
  }
}