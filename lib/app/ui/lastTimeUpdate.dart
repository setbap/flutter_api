import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatter {
  final DateTime _dateTime;
  TimeFormatter(this._dateTime);
  String formatedDate() {
    if (_dateTime != null) {
      return DateFormat.yMMMMEEEEd("en").add_Hms().format(
            _dateTime.add(
              Duration(hours: 3, minutes: 30),
            ),
          );
    } else {
      return "nullll";
    }
  }
}

class LastTimeUpdate extends StatelessWidget {
  final DateTime time;
  final TimeFormatter _formatter;

  LastTimeUpdate({this.time}) : _formatter = TimeFormatter(time);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Text(
          _formatter.formatedDate(),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.red,
              ),
        ),
      ),
    );
  }
}
