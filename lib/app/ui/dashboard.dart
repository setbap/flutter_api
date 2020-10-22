import 'dart:io' show SocketException;

import 'package:flutter/material.dart';
import 'package:flutter_api/app/models/endPointModel.dart';
import 'package:flutter_api/app/repositories/data_repositorries.dart';
import 'package:flutter_api/app/services/api.dart';
import 'package:flutter_api/app/ui/DashboardItem.dart';
import 'package:flutter_api/app/ui/lastTimeUpdate.dart';
import 'package:provider/provider.dart';

import 'alertModal.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({@required this.title});

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndPointDataModel _cases = EndPointDataModel.initial();

  _updateData() async {
    try {
      final _dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final cases = await _dataRepository.getAllEndPointData();
      setState(() {
        _cases = cases;
      });
    } on SocketException catch (e) {
      print(e);
      await showAlertModal(
        content: "internet error",
        context: context,
        okBtnText: "ok",
        title: "error",
      );
    } catch (e) {
      print(e);
      await showAlertModal(
        content: "unknown error",
        context: context,
        okBtnText: "ok",
        title: "error",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cases = Provider.of<DataRepository>(context, listen: false)
        .getAllEndPointCachedData();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _updateData();
        },
        child: ListView(
          children: [
            LastTimeUpdate(
              time: _cases.data[ApiEndPoint.cases]?.time,
            ),
            ...ApiEndPoint.values
                .map(
                  (e) => DashboardItem(
                    endPoint: e,
                    value: _cases.data[e].value,
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
