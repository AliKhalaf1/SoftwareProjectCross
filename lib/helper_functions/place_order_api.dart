library PlaceOrderHelperFunctions;

import '../models/event_promocode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'log_in.dart';

Future<String> postOrder(String eventId, String firstName, String lasttName,
    String email, String creationDate, int totalPrice, String eventImg) async {
  var uri = Uri.parse('${Constants.host}/orders/$eventId/add_order');
  print(uri);
  String token = await getToken();
  Map<String, String> reqHeaders = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json"
  };
  var body = json.encode(
    {
      "first_name": firstName,
      "last_name": lasttName,
      "email": email,
      "event_id": eventId,
      "created_date": creationDate,
      "price": totalPrice,
      "image_link": eventImg,
    },
  ); //body

  final response = await http.post(uri, headers: reqHeaders, body: body);

  var resCode = response.statusCode;
  print('-----------------');
  print("ResCode:");
  print(resCode);
  print('-----------------');
  if (resCode == 200) {
    return jsonDecode(response.body)['id'];
  }
  return "1000";
}

Future<bool> addAtendee(
  String firstName,
  String lasttName,
  String email,
  String type_of_reseved_ticket,
  String order_id,
  String eventId,
) async {
  var uri = Uri.parse('${Constants.host}/attendees/$eventId/add_attendee');
  print(uri);
  String token = await getToken();
  Map<String, String> reqHeaders = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json"
  };
  var body = json.encode(
    {
      "first_name": firstName,
      "last_name": lasttName,
      "email": email,
      "type_of_reseved_ticket": type_of_reseved_ticket,
      "order_id": order_id,
      "event_id": eventId,
    },
  ); //body

  final response = await http.post(uri, headers: reqHeaders, body: body);

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
