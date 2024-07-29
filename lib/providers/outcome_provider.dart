import 'dart:convert';
import 'dart:developer';

import 'package:abramo_coffee/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class OutcomeProvider {
  static Future<String> getOutcomeByTime(String time) async {
    String outcomeUrl = "$baseUrl${Endpoint.api_outcome_time}$time";

    final authData = await AuthProvider.getAuthData();

    try {
      var response = await http.get(
        Uri.parse(outcomeUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        log("TODAY Income => ${responseJson['data']}");
      }

      return responseJson['data'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
