import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    log("API Request Sent");

    if (response.statusCode == 200) {
      String data = response.body;

      //log("JSON received");
      //log(data);

      return jsonDecode(data);
    } else {
      log('status code: ' + response.statusCode.toString());
    }
  }
}
