import 'package:app/database/repositories/PlotDAORepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../entity/plot.dart';

class PlotModel extends ChangeNotifier {

  late PlotDAORepository _plotDAORepository;
  List<MyPlot> plots = [];

  PlotModel(){
    _plotDAORepository = GetIt.instance.get<PlotDAORepository>();
    watchAllPlots();
  }

  void watchAllPlots(){
    _plotDAORepository.watchAllPlots().listen((plots) {
      this.plots = plots;
      print("!!!! I notify all listeners bitch!");
      notifyListeners();
    });
  }

  Future<void> addPlot(String plotName, String imagePath) async {
    var newPlot = MyPlot(plotName: plotName, imagePath: imagePath);
    await _plotDAORepository.addPlot(newPlot);
  }

  Future<void> updatePlot(MyPlot plot) async {
    await _plotDAORepository.updatePlot(plot);
  }

  Future<void> deletePlot(MyPlot plot) async {
    await _plotDAORepository.deletePlot(plot);
  }

  Future<List<MyPlot>> getPlots(){
    return _plotDAORepository.findAllPlots();
  }
}