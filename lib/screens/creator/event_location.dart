import 'package:Eventbrite/screens/creator/event_title.dart';
import 'package:Eventbrite/screens/creator/main_event_form.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';

import '../../widgets/arc_painter.dart';
import '../../widgets/tab_bar_Events.dart';

enum eventPlace {
  Venue,
  Online,
}

class EventLocation extends StatefulWidget {
  const EventLocation({super.key});
  static const route = '/EventLocation';

  @override
  State<EventLocation> createState() => _EventLocationState();
}

class _EventLocationState extends State<EventLocation> {
  LatLng _userPosition = const LatLng(0, 0);

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      _userPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  eventPlace thePlace = eventPlace.Venue;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
        child: ListView(
          children: [
            PopupMenuButton(
              color: Colors.white,
              initialValue: thePlace,
              onSelected: (eventPlace item) {
                setState(() {
                  thePlace = item;
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Venue'),
                  value: eventPlace.Venue,
                ),
                const PopupMenuItem(
                  child: Text('Online event'),
                  value: eventPlace.Online,
                ),
              ],
              child: Row(
                children: [
                  Icon(
                    thePlace == eventPlace.Online
                        ? Icons.computer_outlined
                        : Icons.location_on_outlined,
                    color: Colors.black,
                  ),
                  Text(thePlace == eventPlace.Venue ? 'Venue' : 'Online event'),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (thePlace == eventPlace.Venue)
              FittedBox(
                fit: BoxFit.fitHeight,
                child: SearchGooglePlacesWidget(
                  placeholder: "Search for locations",
                  apiKey: 'AIzaSyBQu5amJNSA0nVm4T32R74z9jUWKu5mg5c',
                  language: 'En',
                  location: _userPosition,
                  radius: 3000,
                  onSelected: (place) {
                    address = place.description;
                    //you must navigate
                    int count = 0;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      EventForm.route,
                      (route) => count++ == 4 || route.isFirst,
                    );
                  },
                  onSearch: (Place place) {},
                ),
              )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (thePlace == eventPlace.Venue && address == null) {
            //error
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Enter the location'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            //navigate bs theplace is online
            //address=null
            int count = 0;
            Navigator.pushNamedAndRemoveUntil(
              context,
              EventForm.route,
              (route) => count++ == 4 || route.isFirst,
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black,
              ),
            ),
            CustomPaint(
              painter: ArcPainter(
                startAngle: -90,
                sweepAngle: 270,
                color: Colors.lightGreen,
                strokeWidth: 4,
              ),
              child: const SizedBox(
                height: 65,
                width: 65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
