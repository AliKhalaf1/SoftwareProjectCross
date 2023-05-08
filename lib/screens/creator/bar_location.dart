import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';

import '../../providers/createevent/createevent.dart';

class BarLocation extends StatelessWidget {
  static const route = '/barLocation';
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Text("Location"),
          backgroundColor: const Color.fromRGBO(31, 10, 61, 1)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 300,
          child: ListView(children: [
            SearchLocation(
              apiKey: 'AIzaSyBQu5amJNSA0nVm4T32R74z9jUWKu5mg5c',
              onSelected: (Place place) {
                event.city = place.description;
                Navigator.pop(
                  context,
                );
              },
              country: 'EG',
            ),
          ]),
        ),
      ),
    );
  }
}
