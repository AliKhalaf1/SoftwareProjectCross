library SingleEventScreen;

import 'dart:ui';

import 'package:Eventbrite/helper_functions/event_tickets_info.dart';
import 'package:Eventbrite/helper_functions/event_promocode_info.dart';
import 'package:Eventbrite/widgets/title_text_1.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:intl/intl.dart';

// import '../helper_functions/log_in.dart';
import '../models/event_promocode.dart';
import '../models/event_tickets.dart';
import '../providers/events/event.dart';
import '../providers/events/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events/fav_events.dart';
import '../widgets/buy_tickets.dart';
import '../widgets/loading_spinner.dart';
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
/// It Know user is logged in or not from
class EventPage extends StatefulWidget {
  // To Be: make this class take its data from API
  // To Be: initialized  by Empty lists in all attr but i but values for teating
  // Initial values:   EventTicketsInfo eventTickets = EventTicketsInfo(['', ''], [0, 0], ['', '']);
  EventTicketsInfo eventTickets = EventTicketsInfo([
    '0',
    '1'
  ], [
    'Regular',
    'VIP'
  ], [
    5,
    2
  ], [
    DateTime.now().subtract(const Duration(days: 10)),
    DateTime.now().add(const Duration(days: 10))
  ], [
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 5))
  ], 50);

  // To Be: make this class take its data from API
  // To Be: Not to give initial value as it could be NULL => make sure ? is added as if no promocode it must be null
  EventPromocodeInfo? eventPromocode = EventPromocodeInfo(
      '0',
      '1234',
      true,
      10,
      'value',
      40,
      DateTime.now().subtract(const Duration(days: 10)),
      DateTime.now().add(const Duration(days: 10)));
  bool isLoading = false;
  bool isLoadingEventApi = false;
  bool isLoadingSimilarEventsApi = false;
  bool isLoadingTicketsApi = false;
  bool isLoadingPromoApi = false;

  // Data passed from navigating screen at initState()
  final String eventId;
  final bool isLogged;
  // To Be: Taken from Api get event by id
  Event loadedEvent = Event(DateTime.now(), DateTime.now(), '', '', false,
      false, '', [], '', '', '', false);

  // To Be: List of similar events to be fetched from Api search by categorey
  // It could be null as there could be no similar events
  List<Event>? similarEvents;

  // Constructor of EventPage scree
  EventPage(this.eventId, this.isLogged, {super.key});

  static const eventPageRoute = '/Event-Page';

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  //----------------------------------------------------- Methods -----------------------------------------------------------//

  // To Be: Get event tickets data with this function as it is called when navigate to tickets modal
  // Hint: you can find similar function at Profile.dart
  void getEventTickets(String eventId) {
    getEventTicketsInfo(eventId).then(
        // To Be: E3mlha beltafsel a7san men dh equal dh lef 3aka kol attr goa classes
        // To Be: be sure that fetch code is 200 succeses to make widget.isLoadingTicketsApi  = false
        // Make sure before assign that lists length must be 2 so dont assign if not valid response ##Note## avaliableQuanitity list must be initialized by zeros
        // example: widget.eventTickets.avaliableQuantaties = eventTicketsdata.avaliableQuantaties
        (eventTicketsdata) {
      setState(() {
        // make it false to render the page
        widget.isLoadingTicketsApi = false;
        // widget.eventTickets = eventTicketsdata;
      });
    });
  }

  // To Be: Get event tickets data with this function as it is called when navigate to tickets modal
  // Hint: you can find similar function at Profile.dart
  void getEventPromo(String eventId) {
    getEventPrmocodeInfo(eventId).then(
        // To Be: E3mlha beltafsel a7san men dh equal dh lef 3aka kol attr goa classes
        // To Be: be sure that fetch code is 200 succeses to make widget.isLoadingPromoApi  = false
        // Make sure before assign that lists length must be 2 so dont assign if not valid response ##Note## avaliableQuanitity list must be initialized by zeros
        // example: widget.eventTickets.avaliableQuantaties = eventTicketsdata.avaliableQuantaties
        (eventPromodata) {
      setState(() {
        // make it false to render the page
        widget.isLoadingPromoApi = false;
        // widget.eventPromocode = eventPromodata;
      });
    });
  }

  // Open buyTickets model
  void buyTickets(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          //------------------------ user input -------------------//
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              behavior: HitTestBehavior.opaque,
              child: BuyTickets(
                  widget.eventId,
                  widget.loadedEvent.title,
                  '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.loadedEvent.startDate)} EET',
                  widget.eventTickets,
                  widget.eventPromocode));
        });
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

  // To Be: Call functions that fetch from APis:
  // 1. Get event info by id
  // 2. Get events similar by same categorey of the event
  // 3. Get event avaliable tickets
  @override
  void initState() {
    //Make screen to be in in loading state
    widget.isLoading = true;
    widget.isLoadingEventApi = true;
    widget.isLoadingSimilarEventsApi = true;
    widget.isLoadingTicketsApi = true;
    widget.isLoadingPromoApi = true;

    // To Be: eventId be used for 3 APIs here

    // 1. Get event info by id
    // To Be: when Fetch success make widget.isLoadingEventApi = false

    // 2. Get events similar by same categorey of the event
    // To Be: when Fetch success make widget.isLoadingSimilarEventsApi = false

    // 3.  Get event avaliable tickets
    getEventTickets(widget.eventId);

    // 4. Get event Promocode
    getEventPromo(widget.eventId);

    //Render page after fetching from Apis
    // Busy wait until all Apis finish their fetch
    // moshkeletha enha b pause application
    // To Be: Move [widget.isLoadingEventApi = false; & widget.isLoadingSimilarEventsApi = false;] to theit API fetch
    widget.isLoadingEventApi = false;
    widget.isLoadingSimilarEventsApi = false;
    widget.isLoadingTicketsApi = false;
    widget.isLoadingPromoApi = false;
    // while (widget.isLoadingEventApi ||
    //     widget.isLoadingSimilarEventsApi ||
    //     widget.isLoadingTicketsApi || widget.isLoadingPromoApi) {}

    widget.isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //----------------------- Event provider ------------------------------

    // TO BE: toggle fav state API
    final favsData = Provider.of<FavEvents>(context);

    //----------------------- Event id ------------------------------------
    // TO BE: take this eventId and get event data from API get eventById to be loadedEvent// is the id!
    widget.loadedEvent = Provider.of<Events>(
      context,
      listen: false,
    ).findById(widget.eventId);

    //----------------------- Methods ------------------------------

    // TO BE: toggle fav state API
    Future<void> toggleFav(BuildContext ctx) async {
      //add to favourites list
      // isLogged = await checkLoggedUser();
      setState(() {
        if (widget.isLogged) {
          //Call toggleStatus function from event class
          if (widget.loadedEvent.isFav) {
            favsData.removeEventFromFav(widget.loadedEvent);
          } else {
            favsData.addEventToFav(widget.loadedEvent);
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
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leadingWidth: double.infinity,
          leading: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.loadedEvent.eventImg),
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                  !widget.loadedEvent.isFav
                      ? Icons.favorite_border_rounded
                      : Icons.favorite_sharp,
                  color: !widget.loadedEvent.isFav
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 209, 65, 12),
                ),
              ),
            ),
          ]),

      //--------------------------------------- Body --------------------------------------------------------
      body: widget.isLoading == true
          ? const LoadingSpinner()
          : Stack(fit: StackFit.loose, children: [
              //Stack 1st child
              GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: const Color.fromARGB(255, 255, 72, 0),
                child: SingleChildScrollView(
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
                              widget.loadedEvent.eventImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // -------------------- Event Name --------------------
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TitleText1(
                            widget.loadedEvent.title,
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
                            title: Text(DateFormat('EEEE, MMMM d').format(
                                widget.loadedEvent.startDate.toLocal())),
                            subtitle: Text(
                                'Starts at: ${DateFormat('hh:mmaaa').format(widget.loadedEvent.startDate.toLocal())}'),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.ondemand_video_outlined,
                                size: 15),
                            title: Text(
                              (widget.loadedEvent.state == true)
                                  ? 'Online event'
                                  : 'Offline event',
                            ),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:
                                const Icon(Icons.access_time_rounded, size: 15),
                            title: Text(
                                'Duration: ${getDuration(widget.loadedEvent.endDate.difference(widget.loadedEvent.startDate))}'),
                          ),
                        ),

                        // -------------------- Organization Name --------------------
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 10),
                            child: const Text(
                              'Organizer',
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
                          child: Row(
                            children: [
                              const Icon(
                                key: Key("person"),
                                Icons.person,
                                color: Color.fromRGBO(62, 9, 137, 1),
                                size: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 7),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(widget.loadedEvent.organization,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        ),

                        // ---------------------- About ----------------
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 10),
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
                          child: TitleText2(widget.loadedEvent.description),
                        ),
                        const SizedBox(height: 30),

                        // ------------- More like evnets -----------
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 10),
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
                        widget.similarEvents == null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: const TitleText2(
                                    'No similar events right now'),
                              )
                            : SizedBox(
                                height: 270,
                                width: double.infinity,
                                child: GlowingOverscrollIndicator(
                                  axisDirection: AxisDirection.right,
                                  color: const Color.fromARGB(255, 255, 72, 0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.similarEvents == null
                                        ? 0
                                        : widget.similarEvents
                                            ?.length, // To Be: substitute with number of events in collection
                                    itemBuilder: (ctx, index) {
                                      return ChangeNotifierProvider.value(
                                          // To Be: get event from events of the collection by get events by collection API
                                          value: widget.loadedEvent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: PhysicalModel(
                                                color: Colors.white,
                                                elevation: 10.0,
                                                child: MoreLikeEventCard(widget
                                                    .similarEvents![index])),
                                          ));
                                    },
                                  ),
                                ),
                              ),

                        //------------ End of Page -------------
                        Container(
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //--------------------------------------- Tickets modal --------------------------------------------------------
              //Stack 2nd child
              //To Be: if events tickets avaliability : not avliable disable Tickets Btn (get from event API tickets.avaliable) => add this check OPED with [widget.loadedEvent.startDate.toUtc().isBefore(DateTime.now().add(const Duration(hours: 1)).toUtc())]

              // ----- Checks -----
              // 1. is logged user
              // 2. is event before now
              // 3. To Be: is there is avliable tickets (avaliable tickets > 0)
              if (!widget.isLogged ||
                  widget.loadedEvent.startDate.toUtc().isBefore(
                      DateTime.now().add(const Duration(hours: 1)).toUtc()) ||
                  (widget.eventTickets.avaliableQuantaties[0] +
                          widget.eventTickets.avaliableQuantaties[1]) ==
                      0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TransparentButtonNoIcon(
                        key: const Key("BuyTicketsBtn"),
                        'Tickets',
                        buyTickets,
                        true,
                        '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.loadedEvent.startDate)} EET'),
                  ),
                )
              else
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TransparentButtonNoIcon(
                        key: const Key("BuyTicketsBtn"),
                        'Tickets',
                        buyTickets,
                        false,
                        '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.loadedEvent.startDate)} EET'),
                  ),
                ),
            ]),
    );
  }
}
