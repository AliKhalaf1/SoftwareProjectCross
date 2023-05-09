library EventPromocodeHelperFunctions;

import '../models/event_promocode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

Future<List<EventPromocodeInfo>> getEventPrmocodeInfo(String eventId) async {
  List<EventPromocodeInfo> eventPromos = <EventPromocodeInfo>[];
  var uri = Uri.parse('${Constants.host}/promocodes/event_id/$eventId');
  print(uri);
  var response = await http.get(
    uri,
  );

  var resCode = response.statusCode;
  print('-----------------');
  print("ResCode:");
  print(resCode);
  print('-----------------');
  if (resCode == 200) {
    var resBody = response.body;
    var resData = jsonDecode(resBody);
    if (resData.length > 0) {
      for (int i = 0; i < resData.length; i++) {
        EventPromocodeInfo newpromo = EventPromocodeInfo(
          resData[i]['id'],
          resData[i]['name'],
          resData[i]['is_limited'],
          resData[i]['current_amount'],
          resData[i]['is_percentage'],
          resData[i]['discount_amount'],
          DateTime.parse(resData[i]['start_date_time']),
          DateTime.parse(resData[i]['end_date_time']),
        );
        eventPromos.add(newpromo);
      }
      return eventPromos;
    } else {
      return [];
    }
  } else {
    return [];
  }
}

Future<bool> postEventPrmocodeInfo(String promoId) async {
  var uri = Uri.parse(
      '${Constants.host}/promocodes/promocode_id/$promoId/quantity/{quantity}?amount=-1');
  print(uri);
  var response = await http.post(
    uri,
  );

  var resCode = response.statusCode;
  print('-----------------');
  print("ResCode:");
  print(resCode);
  print('-----------------');
  if (resCode == 200) {
    return true;
  }
  return false;
}
