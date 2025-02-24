import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
          .timeout(const Duration(seconds: 50));

      jsonResponse = _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Timeout');
    }

    return jsonResponse;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error communicating with Server, StatusCode: ${response.statusCode}');
    }
  }
}
