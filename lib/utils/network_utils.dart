import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      print("No Internet Connection");
      return false;
    }

    // Extra Check: Test Internet Access
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      print("Internet Available: ${response.statusCode == 200}");
      return response.statusCode == 200;
    } catch (_) {
      print("No Internet Access");
      return false;
    }
  }
}
