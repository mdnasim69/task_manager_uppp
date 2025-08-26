import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? ResponseBody;
  final bool isSuccess;
  final String errorMassage;

  NetworkResponse(
      {required this.statusCode,
      required this.isSuccess,
      this.ResponseBody,
      this.errorMassage ='something went wrong'
      });
}

class Networkcaller {
  static Future<NetworkResponse> getReqest(url) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri,headers: {'token':AuthController.getToken!},);
      final ResponseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          ResponseBody: ResponseData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMassage: 'request fail',
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postReqest(
      url, Map<String, dynamic> postBody) async {
    try {
      Uri uri = Uri.parse(url);

      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json','token':AuthController.getToken!},
        body: jsonEncode(postBody),
      );
      final ResponseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          ResponseBody: ResponseData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMassage: 'reqest fail',
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMassage: e.toString(),
      );
    }
  }
}
