import 'package:flutter/cupertino.dart';

class ReturnDataModel {
  final int value;
  final DateTime time;

  ReturnDataModel({@required this.value, this.time}) : assert(value != null);
}
