import 'package:flutter/cupertino.dart';
import 'package:flutter_api/app/services/api_keys.dart';

enum ApiEndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

extension Stringi on ApiEndPoint {
  String stringify() {
    switch (this) {
      case ApiEndPoint.cases:
        return 'cases';
      case ApiEndPoint.casesConfirmed:
        return 'casesConfirmed';
      case ApiEndPoint.casesSuspected:
        return 'casesSuspected';
      case ApiEndPoint.deaths:
        return 'deaths';
      case ApiEndPoint.recovered:
      default:
        return 'recovered';
    }
  }

  String jsonKey() {
    switch (this) {
      case ApiEndPoint.cases:
        return 'cases';
      case ApiEndPoint.casesConfirmed:
      case ApiEndPoint.casesSuspected:
      case ApiEndPoint.deaths:
      case ApiEndPoint.recovered:
      default:
        return 'data';
    }
  }
}

class Api {
  Api({@required this.apiKey});
  factory Api.sandbox() => Api(apiKey: ApiKeys.covSandBoxKey);

  static final String baseUrl = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(
        scheme: "https",
        host: baseUrl,
        path: "token",
      );

  Uri endPointUri(ApiEndPoint apiEndPoint) =>
      Uri(scheme: "https", host: baseUrl, path: apiEndPoint.stringify());

  final String apiKey;
}
