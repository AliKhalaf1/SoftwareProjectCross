library NearbyEventsScreen;

import 'package:flutter/material.dart';

import 'filters.dart';

class NearbyEvents extends StatefulWidget {
  const NearbyEvents({super.key});

  @override
  State<NearbyEvents> createState() => _NearbyEventsState();
}

class _NearbyEventsState extends State<NearbyEvents> {
  @override
  Widget build(BuildContext context) {
    /* Method handler to return back after select browsing in what */
    void selectLocation(BuildContext ctx) {
      // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //   return FilterScreen([]);
      // }));
    }

    return Scaffold(
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
                  onTap: () {},
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
