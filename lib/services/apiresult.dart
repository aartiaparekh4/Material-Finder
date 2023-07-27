// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

class APIResult<T> {
  String? status;
  String? statusCode;
  bool? isDisplayMessage;
  String? message;
  T? recordList;
  int? totalRecords;
  dynamic value;
  Error? error;

  APIResult({
    this.status,
    this.isDisplayMessage,
    this.message,
    this.recordList,
    this.totalRecords,
    this.value,
    this.error,
  });

  APIResult.fromJson(Map<String, dynamic> json, T _recordList) {
    try {
      status = json["status"].toString();
      statusCode = json["statusCode"].toString();
      isDisplayMessage = json['isDisplayMessage'];
      message = json["message"];
      recordList = _recordList;
      totalRecords = json["totalRecords"];
      value = json["value"];
      error = json["error"] != null ? Error.fromJson(json["error"]) : null;
    } catch (e) {
      print("Exception - APIResult.dart - APIResult.fromJson(): ${e.toString()}");
    }
  }
}

class Error {
  String? apiName;
  String? apiType;
  String? fileName;
  dynamic functionName;
  dynamic lineNumber;
  dynamic typeName;
  String? stack;

  Error({
    this.apiName,
    this.apiType,
    this.fileName,
    this.functionName,
    this.lineNumber,
    this.typeName,
    this.stack,
  });

  Error.fromJson(Map<String, dynamic> json) {
    try {
      apiName = json["apiName"];
      apiType = json["apiType"];
      fileName = json["fileName"];
      functionName = json["functionName"];
      lineNumber = json["lineNumber"];
      typeName = json["typeName"];
      stack = json["stack"];
    } catch (e) {
      print("Exception - Error.dart - Error.fromJson(): $e");
    }
  }
}

class DioResult<T> {
  int? statusCode;
  String? status;
  String? message;
  T? data;

  DioResult({this.statusCode, this.data, this.status});
  DioResult.fromJson(dynamic response, T recordList) {
    try {
      status = response.data != null && response.data.length > 0 && response.data['status'] != null ? response.data['status'].toString() : '';
      message = response.data['message'];
      statusCode = response.statusCode;
      data = recordList;
    } catch (e) {
      print("Exception - dioResult.dart - DioResult.fromJson():$e");
    }
  }
}
