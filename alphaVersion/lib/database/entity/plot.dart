import 'package:floor/floor.dart';

@Entity(tableName: 'MyPlot')
class MyPlot {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: "plotName")
  String plotName;
  String imagePath;

  MyPlot({required this.plotName, required this.imagePath, this.id});
}
