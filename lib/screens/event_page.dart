library SingleEventScreen;

import '../providers/events/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@category User}
/// {@category Screens}
///
///
///
class EventPage extends StatelessWidget {
  const EventPage({super.key});

  static const eventPageRoute = '/Event-Page';

  @override
  Widget build(BuildContext context) {
    final eventId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Events>(
      context,
      listen: false,
    ).findById(eventId);
    return Scaffold(
      //Edit app-bar to be as application
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.eventImg,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${loadedProduct.creatorFollowers}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
