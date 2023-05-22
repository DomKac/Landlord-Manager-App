import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(tableName: 'MyObject')
class MyObject {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int plotId;
  String objectName;
  String color;
  String category;
  String notes;
  
  MyObject({
    required this.plotId,
    required this.objectName,
    required this.color,
    required this.category,
    required this.notes,
    this.id
  });
}
