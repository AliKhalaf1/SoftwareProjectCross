library SingleEventScreen;

import 'dart:ui';

import 'package:Eventbrite/widgets/title_text_1.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:intl/intl.dart';

import '../helper_functions/log_in.dart';
// import '../providers/events/event.dart';
import '../providers/events/event.dart';
import '../providers/events/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events/fav_events.dart';
import '../widgets/event_card.dart';
import '../widgets/more_like_events_card.dart';
import '../widgets/transparent_button_no_icon.dart';
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
  //---------------- Methods -----------------//
  // To Be: Navigate to buy a ticket
  void buyTickets(BuildContext ctx) {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return TabBarScreen(title: 'Search', tabBarIndex: 1);
    // }));
  }

  //Get duration
  String getDuration(Duration d) {
    int month, weeks, days, minutes;
    if (d.inDays != 0) {
      if (d.inDays >= 30) {
        month = (d.inDays / 30).floor();
        weeks = ((d.inDays - (month * 30)) / 7).floor();
        return weeks == 0
            ? '${month.toString()} month '
            : '${month.toString()} month ${weeks.toString()} weeks';
      }
      if (d.inDays >= 7) {
        weeks = (d.inDays / 7).floor();
        days = ((d.inDays - (7 * weeks)));
        return days == 0
            ? (weeks == 1
                ? '${weeks.toString()} week '
                : '${weeks.toString()} weeks ')
            : (weeks == 1
                ? '${weeks.toString()} week ${(days.toString())} days'
                : '${weeks.toString()} weeks ${days.toString()} days');
      }
      return d.inDays == 1
          ? '${d.inDays.toString()} day'
          : '${d.inDays.toString()} days';
    } else if (d.inHours != 0) {
      minutes = (d.inMinutes % 60);
      if (minutes != 0) {
        return '${d.inHours.toString()}h ${minutes}m';
      }
      return d.inHours == 1
          ? '${d.inHours.toString()} hour'
          : '${d.inHours.toString()} hours';
    } else {
      return '${d.inMinutes.toString()} minutes';
    }
  }

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
      body: Stack(
        fit: StackFit.loose,
        children: [
          //Stack 1st child
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // -------------------- Event image --------------------
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

                  // -------------------- Event Name --------------------
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TitleText1(
                      loadedEvent.title,
                    ),
                  ),

                  // -------------------- Event time/location --------------------
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 10, top: 0),
                      child: const Text(
                        'Times are displayed in your local timezone',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15.5,
                            color: Color.fromRGBO(121, 121, 121, 0.875)),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today, size: 15),
                      title: Text(DateFormat('EEEE, MMMM d')
                          .format(loadedEvent.startDate.toLocal())),
                      subtitle: Text(
                          'Starts at: ${DateFormat('hh:mmaaa').format(loadedEvent.startDate.toLocal())}'),
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          const Icon(Icons.ondemand_video_outlined, size: 15),
                      title: Text(
                        (loadedEvent.state == EventState.online)
                            ? 'Online event'
                            : 'Offline event',
                      ),
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.access_time_rounded, size: 15),
                      title: Text(
                          'Duration: ${getDuration(loadedEvent.endDate.difference(loadedEvent.startDate))}'),
                    ),
                  ),

                  // ---------------------- About ----------------
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(right: 15, bottom: 10),
                      child: const Text(
                        'About',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.3,
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(17, 3, 59, 1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TitleText2(loadedEvent.description),
                  ),
                  const SizedBox(height: 30),

                  // ------------- More like evnets -----------
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(right: 15, bottom: 10),
                      child: const Text(
                        'More like this',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.3,
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(17, 3, 59, 1)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.right,
                      color: const Color.fromARGB(255, 255, 72, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            7, // To Be: substitute with number of events in collection
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                              // To Be: get event from events of the collection by get events by collection API
                              value: Event(
                                  DateTime.now(),
                                  DateTime.now().add(
                                      const Duration(minutes: 30, hours: 5)),
                                  'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
                                  'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
                                  EventState.online,
                                  false,
                                  "Science",
                                  ['smart', 'wellness', 'aykalam'],
                                  '2',
                                  'Ancara messi ancara messi'),
                              child: const MoreLikeEventCard());
                        },
                      ),
                    ),
                  ),

                  //------------ End of Page -------------
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),

          //Stack 2nd child
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TransparentButtonNoIcon(
                  key: const Key("BuyTicketsBtn"),
                  'Tickets',
                  buyTickets,
                  false),
            ),
          )
        ],
      ),
    );
  }
}
