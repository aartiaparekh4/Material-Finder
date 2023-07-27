// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:material_finder/services/apiresult.dart';

import '../model/imges_model.dart';

class APIHelper {
  String sunder = 'AQICAHjfMlc8BGawlDtCeXhKzwfnF0+YRgxzGJumvQ6fMGsAOAEASFvt0weFnUz0Q+NVPqxpAAAAYTBfBgkqhkiG9w0BBwagUjBQAgEAMEsGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMdZSufIqL3KlHUmwtAgEQgB6sauLbIcDZBAfRQlqHsKoN4TFC5dzIoDI5vUgtnxs=';
  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResult():$e");
    }
  }

// //psychologists service doctrolist Get
//   Future<dynamic> getSeviceDoctroList() async {
//     try {
//       final response = await http.post(
//         Uri.parse("${global.baseUrl}${AppConstant.DOCTOR_LIST}"),
//         headers: {"authorization": "Basic ${base64.encode("sunder:$sunder".codeUnits)}", "Content-Type": 'application/json'},
//       );
//       print('done : $response');
//       Map<String, dynamic> recordList;
//       recordList = {"statusCode": null, "recordList": []};

//       recordList['statusCode'] = json.decode(response.body)["status"]['responseCode'];
//       if (response.statusCode == 200) {
//         // recordList['recordList'] = List<DoctorListModel>.from(json.decode(response.body)["response"]["doctorList"].map((e) => DoctorListModel.fromJson(e)));
//       } else {
//         recordList['recordList'] = [];
//       }
//       return recordList;
//     } catch (e) {
//       print("Exception -  apiHelper.dart - getSeviceDoctroList():$e");
//     }
//   }

  Future<dynamic> uploadImages(image) async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.post(
        "http://3.143.170.193/upload_image/",
        data: FormData.fromMap({"image": image}),
        options: Options(contentType: "multipart/form-data; boundary=<calculated when request is sent>"),
      );
      // headers: {"Content-Type": 'application/json'},
      // body: json.encode({"image": image}),

      print('done : $response');
      dynamic recordList;
      // recordList = {"statusCode": null, "recordList": []};

      // recordList['statusCode'] = json.decode(response.body)["status"]['responseCode'];
      if (response.statusCode == 200) {
        if (response.data['result'] != "No data") {
          recordList = ImagesModel.fromJson(response.data['result']);
        } else {
          recordList = response.data['result'];
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - uploadImages():$e");
    }
  }

  Future<dynamic> getImagesList() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get(
        "http://3.143.170.193/list_images/",
        options: Options(contentType: "multipart/form-data; boundary=<calculated when request is sent>"),
      );
      // headers: {"Content-Type": 'application/json'},
      // body: json.encode({"image": image}),

      print('done : $response');
      dynamic recordList;
      // recordList = {"statusCode": null, "recordList": []};

      // recordList['statusCode'] = json.decode(response.body)["status"]['responseCode'];
      if (response.statusCode == 200) {
        recordList = response.data['image_files'];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception -  apiHelper.dart - uploadImages():$e");
    }
  }
}
