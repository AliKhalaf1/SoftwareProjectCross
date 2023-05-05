import 'package:flutter/material.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';

class BarLocation extends StatelessWidget {
  static const route = '/barLocation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 300,
          child: ListView(children: [
            SearchLocation(
              apiKey: 'AIzaSyBQu5amJNSA0nVm4T32R74z9jUWKu5mg5c',
              onSelected: (Place place) {
                print(place.description);
              },
              country: 'EG',
            ),
          ]),
        ),
      ),
    );
  }
}