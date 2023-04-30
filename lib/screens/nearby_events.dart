library NearbyEventsScreen;

import 'package:Eventbrite/helper_functions/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'filters.dart';

/// {@category user}
///
/// {@category Screens}
///
/// This Page is used to display the nearby events.

class NearbyEvents extends StatefulWidget {
  const NearbyEvents({super.key});

  @override
  State<NearbyEvents> createState() => _NearbyEventsState();
}

class _NearbyEventsState extends State<NearbyEvents> {
  @override
  Widget build(BuildContext context) {
    /* Method handler to return back after select browsing in what */
    void selectLocation(BuildContext ctx) {}

    void getLocation(BuildContext ctx) {
      // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //   return FilterScreen();
      // }));

      determinePosition().then((value) {
        placemarkFromCoordinates(value.latitude, value.longitude).then((loc) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Your location is ${loc[0].locality}, ${loc[0].subAdministrativeArea}, ${loc[0].administrativeArea}, ${loc[0].country} ")));
        });
      }).catchError((error) {
        String error_text = error.toString();

        showAboutDialog(context: context, children: [
          Text(
            error_text,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ]);
      });
    }

    return Scaffold(
      key: const Key("NearByScreen"),
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: <Widget>[
              //-------- 1st child ---------
              const TextField(
                key: Key("FindNearbyEventsTextField"),
                cursorWidth: 0.5,
                cursorColor: Colors.grey,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 67, 96, 244),
                ),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Find events in...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(229, 41, 41, 41), width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 67, 96, 244), width: 2.0),
                  ),
                ),
              ),

              //-------- 2nd child ---------
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                  key: const Key("GoToSelectLocation"),
                  onTap: () => getLocation(context),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 214, 241, 247),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.my_location,
                          color: Color.fromARGB(255, 67, 96, 244),
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Nearby',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 41, 74, 240),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'current location',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 90, 90, 90),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //-------- 3rd child ---------
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Browsing in',
                        style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      key: const Key("SelectBrowsingIn"),
                      onTap: () => selectLocation(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Online events',
                            style: TextStyle(
                                color: Color.fromARGB(255, 27, 27, 27),
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 82, 82, 83),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Virtual attendance',
                      style: TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
