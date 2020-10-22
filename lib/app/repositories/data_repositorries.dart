import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_api/app/models/ReturnDataModel.dart';
import 'package:flutter_api/app/models/endPointModel.dart';
import 'package:flutter_api/app/services/api.dart';
import 'package:flutter_api/app/services/cache.service.dart';
import 'package:http/http.dart' show Response;
import '../services/api.service.dart';

class DataRepository {
  DataRepository({
    @required ApiService apiService,
    @required CacheService cacheService,
  })  : _apiService = apiService,
        _cacheService = cacheService;

  final ApiService _apiService;
  final CacheService _cacheService;

  String _accessToken = "";

  Future<ReturnDataModel> getData({@required ApiEndPoint endPoint}) async =>
      await _getDataWithTokenGeneric<ReturnDataModel>(
        getDataFn: () => _apiService.getEndPoinrData(
          accessToken: _accessToken,
          apiEndPoint: endPoint,
        ),
      );

  EndPointDataModel getAllEndPointCachedData() =>
      _cacheService.getEndPoitChaced();

  Future<EndPointDataModel> getAllEndPointData() async =>
      await _getDataWithTokenGeneric<EndPointDataModel>(
        getDataFn: _getAllEndPointData,
      );

  Future<EndPointDataModel> _getAllEndPointData() async {
    final responseData = await Future.wait([
      getData(endPoint: ApiEndPoint.cases),
      getData(endPoint: ApiEndPoint.casesSuspected),
      getData(endPoint: ApiEndPoint.casesConfirmed),
      getData(endPoint: ApiEndPoint.deaths),
      getData(endPoint: ApiEndPoint.recovered),
    ]);
    var data = EndPointDataModel(data: {
      ApiEndPoint.cases: responseData[0],
      ApiEndPoint.casesSuspected: responseData[1],
      ApiEndPoint.casesConfirmed: responseData[2],
      ApiEndPoint.deaths: responseData[3],
      ApiEndPoint.recovered: responseData[4],
    });
    _cacheService.setEndPointData(data);
    return data;
  }

  Future<T> _getDataWithTokenGeneric<T>(
      {Future<T> Function() getDataFn}) async {
    try {
      if (_accessToken == "") {
        _accessToken = await _apiService.getAccessToken();
      }
      return await getDataFn();
    } on Response catch (response) {
      if (response.statusCode == HttpStatus.unauthorized) {
        _accessToken = await _apiService.getAccessToken();
        return await getDataFn();
      }
      rethrow;
    }
  }
}
