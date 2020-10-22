import 'dart:convert';
import 'dart:io' show HttpStatus;
import 'package:flutter/cupertino.dart';
import 'package:flutter_api/app/models/ReturnDataModel.dart';
import 'package:flutter_api/app/services/api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService({@required this.api});

  final Api api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {"Authorization": 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      final accessToken = data["access_token"];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print("url:${api.tokenUri()} , faild , \n ");
    print("token:${api.apiKey} , faild , \n ");
    throw response;
  }

  Future<ReturnDataModel> getEndPoinrData({
    @required String accessToken,
    @required ApiEndPoint apiEndPoint,
  }) async {
    final response = await http.get(
      api.endPointUri(apiEndPoint).toString(),
      headers: {"Authorization": 'Bearer $accessToken'},
    );
    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty && data[0][apiEndPoint.jsonKey()] != null) {
        return ReturnDataModel(
            value: data[0][apiEndPoint.jsonKey()],
            time: DateTime.tryParse(
              data[0]["date"],
            ));
      }
    }
    print("url:${api.endPointUri(apiEndPoint).toString()} , faild , \n ");
    print("token:$accessToken , faild , \n ");
    throw response;
  }
}
