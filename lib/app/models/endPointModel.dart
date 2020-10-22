import 'package:flutter/foundation.dart';
import 'package:flutter_api/app/services/api.dart';

import 'ReturnDataModel.dart';

class EndPointDataModel {
  const EndPointDataModel({@required this.data});

  final Map<ApiEndPoint, ReturnDataModel> data;

  factory EndPointDataModel.initial() {
    Map<ApiEndPoint, ReturnDataModel> initiaData = {
      ApiEndPoint.cases: ReturnDataModel(value: 0, time: null),
      ApiEndPoint.casesSuspected: ReturnDataModel(value: 0, time: null),
      ApiEndPoint.casesConfirmed: ReturnDataModel(value: 0, time: null),
      ApiEndPoint.deaths: ReturnDataModel(value: 0, time: null),
      ApiEndPoint.recovered: ReturnDataModel(value: 0, time: null),
    };
    return EndPointDataModel(data: initiaData);
  }

  ReturnDataModel get cases => data[ApiEndPoint.cases];
  ReturnDataModel get casesSuspected => data[ApiEndPoint.casesSuspected];
  ReturnDataModel get casesConfirmed => data[ApiEndPoint.casesConfirmed];
  ReturnDataModel get deaths => data[ApiEndPoint.deaths];
  ReturnDataModel get recovered => data[ApiEndPoint.recovered];
}
