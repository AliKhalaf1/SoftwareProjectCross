library SingleEventScreen;

import 'dart:ui';

import 'package:Eventbrite/widgets/title_text_1.dart';

import '../helper_functions/log_in.dart';
// import '../providers/events/event.dart';
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
/// It knows the event to display from (event.id) that is passed to naivator.pushNamed
///
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

    // TO BE: toggle fav state API
    final favsData = Provider.of<FavEvents>(context);

    //----------------------- Event id ------------------------------------
    // TO BE: take thid eventId and get event data from API get eventById
    final eventId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedEvent = Provider.of<Events>(
      context,
      listen: false,
    ).findById(eventId);

    //----------------------- Methods ------------------------------

    // TO BE: toggle fav state API
    Future<void> toggleFav(BuildContext ctx) async {
      //add to favourites list
      bool isLogged = await checkLoggedUser();
      setState(() {
        if (isLogged) {
          //Call toggleStatus function from event class
          if (loadedEvent.isFav) {
            favsData.removeEventFromFav(loadedEvent);
          } else {
            favsData.addEventToFav(loadedEvent);
          }
        } else {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
            return const SignUpOrLogIn();
          }));
        }
      });
    }

    return Scaffold(
      key: const Key('EventPage'),
      //Edit app-bar to be as application
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leadingWidth: double.infinity,
          leading: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(loadedEvent.eventImg),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                key: const Key("GoBackBtn"),
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 255, 255, 255),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                key: const Key("AddToFavBtn"),
                onPressed: () => toggleFav(context),
                icon: Icon(
                  key: const Key("favIcon"),
                  !loadedEvent.isFav
                      ? Icons.favorite_border_rounded
                      : Icons.favorite_sharp,
                  color: !loadedEvent.isFav
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 209, 65, 12),
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.network(
                    loadedEvent.eventImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TitleText1(
                  loadedEvent.description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
