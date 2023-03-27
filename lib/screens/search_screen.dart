library SearchScreen;

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.filter_list_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Online events',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color.fromARGB(229, 41, 41, 41),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Start searching...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(229, 41, 41, 41), width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 15, 106, 181), width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      child: Card(
                        child: Text('Ahmed'),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
