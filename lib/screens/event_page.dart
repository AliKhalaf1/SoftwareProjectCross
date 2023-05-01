library SingleEventScreen;

import '../helper_functions/log_in.dart';
import '../providers/events/event.dart';
import '../providers/events/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events/fav_events.dart';
import 'sign_up/sign_up_or_log_in.dart';

/// {@category User}
/// {@category Screens}
///
///
/// This Page is used to display a single event data.
///
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  static const eventPageRoute = '/Event-Page';

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    //----------------------- Event provider ------------------------------

    // final event = Provider.of<Event>(context, listen: false);
    // final favsData = Provider.of<FavEvents>(context);

    //----------------------- Event id ------------------------------------
    final eventId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Events>(
      context,
      listen: false,
    ).findById(eventId);

    //----------------------- Methods ------------------------------

    // Future<void> toggleFav(BuildContext ctx) async {
    //   //add to favourites list
    //   bool isLogged = await checkLoggedUser();
    //   setState(() {
    //     if (isLogged) {
    //       //Call toggleStatus function from event class
    //       if (event.isFav) {
    //         favsData.removeEventFromFav(event);
    //       } else {
    //         favsData.addEventToFav(event);
    //       }
    //     } else {
    //       Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //         return const SignUpOrLogIn();
    //       }));
    //     }
    //   });
    // }

    return Scaffold(
      key: const Key('EventPage'),
      //Edit app-bar to be as application
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
        actions: [
          Positioned(
              bottom: 2,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(
                  //   key: const Key("AddToFavBtn"),
                  //   onPressed: () => toggleFav(context),
                  //   icon: Icon(
                  //     key: const Key("favIcon"),
                  //     !event.isFav
                  //         ? Icons.favorite_border_rounded
                  //         : Icons.favorite_sharp,
                  //     color: !event.isFav
                  //         ? const Color.fromRGBO(0, 0, 0, 0.7)
                  //         : const Color.fromARGB(255, 209, 65, 12),
                  //   ),
                  // ),
                ],
              )),
        ],
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
