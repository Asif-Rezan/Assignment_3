import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:assignment_2/config/app_url.dart';
import 'package:assignment_2/data/exceptions/app_exceptions.dart';
import 'package:assignment_2/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;


class NetworkServicesApi implements BaseApiServices {
  @override
  Future<dynamic> getTask(String endpoint) async {
    dynamic jsonResponse;

    try {
      final response = await http
          .get(Uri.parse('${AppUrl.baseUrl}/$endpoint'))
          .timeout(Duration(seconds: 50));

      jsonResponse = returnResponse(response);

      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Timeout');
    }

    return jsonResponse;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
