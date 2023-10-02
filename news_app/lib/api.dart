import 'package:http/http.dart';
import 'dart:convert';

import 'constants.dart/string_const.dart';

class Api {
  // final String apiKey = 'cbd4de19ae9f44e9b3d682fff63befda';

  Future<Map<String, dynamic>> fetchNews() async {
    final response = await get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.body;
      return jsonDecode(jsonResponse);
    } else {
      throw Exception('Failed');
    }
  }
}
