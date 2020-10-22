import 'package:flutter_api/app/models/ReturnDataModel.dart';
import 'package:flutter_api/app/models/endPointModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class CacheService {
  final SharedPreferences _preferences;

  const CacheService(this._preferences);

  static endPointTimeKey(ApiEndPoint key) => "$key/time";

  static endPointValueKey(ApiEndPoint key) => "${key.stringify()}/value";

  Future<void> setEndPointData(EndPointDataModel dataModel) async {
    dataModel.data.forEach((key, value) async {
      await _preferences.setInt(endPointValueKey(key), value.value);
      await _preferences.setString(
          endPointTimeKey(key), value.time.toIso8601String());
    });
  }

  EndPointDataModel getEndPoitChaced() {
    Map<ApiEndPoint, ReturnDataModel> data = {};
    bool isNull = false;
    ApiEndPoint.values.forEach((name) {
      final int value = _preferences.getInt(endPointValueKey(name));
      final DateTime time = DateTime.tryParse(
        _preferences.getString(
          endPointTimeKey(name),
        )??"today",
      );
      if (time != null && value != null) {
        data[name] = ReturnDataModel(value: value, time: time);
      } else {
        isNull = true;
      }
    });
    if (isNull) {
      return EndPointDataModel.initial();
    }
    return EndPointDataModel(data: data);
  }
}
