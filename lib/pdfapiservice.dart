import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  static final String BASE_URL = "https://firebasestorage.googleapis.com/v0/b/alap-d3940.appspot.com/o/Certificates%2FPMC%20-%20Roll%20No%20Slip.pdf?alt=media&token=60aa18da-7218-4437-9609-6db028b5aa92";

  static Future<String> loadPDF(String certiUrl) async {
    var response = await http.get(BASE_URL);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
