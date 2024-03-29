library SingleEventScreen;

import 'dart:ui';
import 'package:Eventbrite/helper_functions/Search.dart';
import 'package:Eventbrite/helper_functions/event_tickets_info.dart';
import 'package:Eventbrite/helper_functions/event_promocode_info.dart';
import 'package:Eventbrite/widgets/title_text_1.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// import '../helper_functions/log_in.dart';
import '../helper_functions/Likes_functions.dart';
import '../helper_functions/select_event_api.dart';
import '../models/event_promocode.dart';
import '../models/event_ticket.dart';
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
  // To Be: initialized by Empty list in all attr but i but values for testing
  // Initial values:   List<EventTicketInfo> eventFreeTickets = [];
  List<EventTicketInfo> eventFreeTickets = [];
  // To Be: initialized by Empty list in all attr but i but values for testing
  // Initial values:   List<EventTicketInfo> eventVipTickets = [];
  List<EventTicketInfo> eventVipTickets = [];

  // To Be: make this class take its data from API
  // To Be: Not to give initial value as it could be NULL => make sure ? is added as if no promocode it must be null
  List<EventPromocodeInfo> eventPromocodes = [];
  bool isLoading = true;
  bool disableDependencies = false;

  // Data passed from navigating screen at initState()
  String eventId;
  bool isLogged;
  int eventIdMock;
  // To Be: Taken from Api get event by id
  Event loadedEvent = Event('', DateTime.now(), DateTime.now(), '', '', false,
      false, '', [], '', '', false);

  List<Event> similarEvents = [];

  // Constructor of EventPage scree
  EventPage(this.eventId, this.isLogged, this.eventIdMock, {super.key});

  static const eventPageRoute = '/Event-Page';

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  //----------------------------------------------------- Methods -----------------------------------------------------------//

  // Get event data in this function
  Future<void> fetchSelectedEvent(String eventId) async {
    await selectEventApi(eventId).then((value) {
      if (value.id == "") {
        return;
      } else {
        widget.loadedEvent = value;
      }
    });
  }

  // Get similar events data in this function
  Future<void> fetchSimilarEvents() async {
    await search(
      "",
      "",
      "",
      "",
      DateTime(2100, 1, 1),
      DateTime(2100, 1, 1),
      widget.loadedEvent.categ,
    ).then((value) {
      if (value.isEmpty) {
        widget.similarEvents = [];
      } else {
        widget.similarEvents = value;
      }
    });
  }

  // To Be: Get event tickets data with this function as it is called when navigate to tickets modal
  // Hint: you can find similar function at Profile.dart
  Future<void> getEventTickets(String eventId) async {
    await getEventTicketsInfo(eventId).then((eventTicketsdata) {
      widget.eventFreeTickets = eventTicketsdata[0];
      widget.eventVipTickets = eventTicketsdata[1];
    });
  }

  // To Be: Get event tickets data with this function as it is called when navigate to tickets modal
  // Hint: you can find similar function at Profile.dart
  Future<void> getEventPromo(String eventId) async {
    await getEventPrmocodeInfo(eventId).then(
        // To Be: E3mlha beltafsel a7san men dh equal dh lef 3aka kol attr goa classes
        // To Be: be sure that fetch code is 200 succeses to make widget.isLoadingPromoApi  = false
        // Make sure before assign that lists length must be 2 so dont assign if not valid response ##Note## avaliableQuanitity list must be initialized by zeros
        // example: widget.eventTickets.avaliableQuantaties = eventTicketsdata.avaliableQuantaties
        (eventPromodata) {
      widget.eventPromocodes = eventPromodata;
    });
  }

  // Function to fetch 4 Needed Apis
  Future<void> fetchEventApis() async {
    setState(() {
      widget.isLoading = true;
    });

    // --------------- APIS ---------------------------
    // Map<String, String> args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // widget.eventId = args['id'] as String;
    // widget.isLogged = args['islogged'] == '0' ? false : true;
    //Make screen to be in in loading state

    // 1. Get event info by id
    await fetchSelectedEvent(widget.eventId).then((value) async {
      // 2. Get events similar by same categorey of the event
      await fetchSimilarEvents();
    });

    // 3.  Get event avaliable tickets
    await getEventTickets(widget.eventId);

    // 4. Get event Promocode
    await getEventPromo(widget.eventId);
  }

  // Open buyTickets model
  void buyTickets(BuildContext ctx) {
    widget.disableDependencies = false;
    List<EventTicketInfo> evTF = [];
    List<EventTicketInfo> evTV = [];
    for (int i = 0; i < widget.eventFreeTickets.length; i++) {
      evTF.add(EventTicketInfo(
          widget.eventFreeTickets[i].id,
          widget.eventFreeTickets[i].type,
          widget.eventFreeTickets[i].name,
          widget.eventFreeTickets[i].ticketPrice,
          widget.eventFreeTickets[i].startDate,
          widget.eventFreeTickets[i].endDate,
          widget.eventFreeTickets[i].avaliableQuantity));
    }
    for (int i = 0; i < widget.eventVipTickets.length; i++) {
      evTV.add(EventTicketInfo(
          widget.eventVipTickets[i].id,
          widget.eventVipTickets[i].type,
          widget.eventVipTickets[i].name,
          widget.eventVipTickets[i].ticketPrice,
          widget.eventVipTickets[i].startDate,
          widget.eventVipTickets[i].endDate,
          widget.eventVipTickets[i].avaliableQuantity));
    }
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        enableDrag: false,
        builder: (_) {
          widget.disableDependencies = false;
          //------------------------ user input -------------------//
          return GestureDetector(
              // onTap: () {
              //   // FocusScope.of(context).requestFocus(FocusNode());
              // },
              behavior: HitTestBehavior.opaque,
              child: BuyTickets(
                  widget.eventId,
                  widget.loadedEvent.title,
                  '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.loadedEvent.startDate)} EET',
                  evTF,
                  evTV,
                  widget.eventPromocodes,
                  widget.loadedEvent.eventImg));
        });
  }

  // If user not loged in so apper login Btn to show tickets after login
  Future<void> logInNavigate(BuildContext ctx) async {
    widget.disableDependencies = false;
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const SignUpOrLogIn();
    }));
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

  // @override
  // void initState() {
  //   // Render Page After finish
  //   fetchEventApis().then((value) {
  //     setState(() {
  //       widget.isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  // To Be: Call functions that fetch from APis:
  // 1. Get event info by id
  // 2. Get events similar by same categorey of the event
  // 3. Get event avaliable tickets
  // 4. Get promocode
  @override
  void didChangeDependencies() {
    if (widget.disableDependencies) {
      return;
    }
    // --------------- Args Passed from parent widget ---------------------------
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args['eventId'] == null ||
        args['isLogged'] == null ||
        args['eventIdMock'] == null) {
      Navigator.of(context).pop();
    }
    widget.eventId = args['eventId'] as String;
    widget.eventIdMock = (args['eventIdMock'] as int);
    widget.isLogged = args['isLogged'] == '0' ? false : true;

    // Render Page After finish
    fetchEventApis().then((value) {
      isEventLikedHelper(widget.loadedEvent.id, widget.loadedEvent.mockId)
          .then((value) {
        setState(() {
          widget.loadedEvent.isFav = value;
        });
      });

      setState(() {
        widget.isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //----------------------- Event provider ------------------------------

    // TO BE: toggle fav state API
    final favsData = Provider.of<FavEvents>(context);

    // //----------------------- Event id ------------------------------------
    // // TO BE: take this eventId and get event data from API get eventById to be loadedEvent// is the id!
    // widget.loadedEvent = Provider.of<Events>(
    //   context,
    //   listen: false,
    // ).findById(widget.eventId);

    //----------------------- Methods ------------------------------

    // TO BE: toggle fav state API
    Future<void> toggleFav(BuildContext ctx, bool check) async {
      //add to favourites list
      // isLogged = await checkLoggedUser();
      if (widget.isLogged) {
        bool status = true;
        //Call toggleStatus function from event class
        if (!check) {
          status = await likeEventHelper(
              widget.loadedEvent.id, widget.loadedEvent.mockId);
        } else {
          status = await UnlikeEventHelper(
              widget.loadedEvent.id, widget.loadedEvent.mockId);
        }
        if (status) {
        } else {
          widget.loadedEvent.isFav = !widget.loadedEvent.isFav;
          ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong!'),
            ),
          );
        }
      } else {
        Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
          return const SignUpOrLogIn();
        }));
      }

      setState(() {
        widget.disableDependencies = true;
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
              decoration:
                  // (widget.loadedEvent.eventImg == null ||
                  //         widget.loadedEvent.eventImg == "")
                  //     ?
                  const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appbarimg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              // : BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(widget.loadedEvent.eventImg),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
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
                  widget.disableDependencies = false;
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
                onPressed: () {
                  bool check = widget.loadedEvent.isFav;
                  setState(() {
                    widget.loadedEvent.isFav = !widget.loadedEvent.isFav;
                  });

                  toggleFav(context, check);
                },
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
          : widget.loadedEvent.id == ""
              ? const SizedBox()
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/no_image_found.png'),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            const Image(
                                      image: AssetImage(
                                          'assets/images/no_image_found.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    image: NetworkImage(
                                        widget.loadedEvent.eventImg),
                                    fit: BoxFit.cover,
                                  )),
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 0),
                                child: const Text(
                                  'Times are displayed in your local timezone',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      color:
                                          Color.fromRGBO(121, 121, 121, 0.875)),
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading:
                                    const Icon(Icons.calendar_today, size: 15),
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
                                leading: const Icon(
                                    Icons.ondemand_video_outlined,
                                    size: 15),
                                title: Text(
                                  (widget.loadedEvent.isOnline == true)
                                      ? 'Online event'
                                      : widget.loadedEvent.city,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.access_time_rounded,
                                    size: 15),
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
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 10),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(widget.loadedEvent.organization,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
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
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 10),
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
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 10),
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
                            widget.similarEvents.isEmpty
                                ? SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: const TitleText2(
                                        'No similar events right now'),
                                  )
                                : SizedBox(
                                    height: 270,
                                    width: double.infinity,
                                    child: GlowingOverscrollIndicator(
                                      axisDirection: AxisDirection.right,
                                      color:
                                          const Color.fromARGB(255, 255, 72, 0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.similarEvents.isEmpty
                                            ? 0
                                            : widget.similarEvents
                                                .length, // To Be: substitute with number of events in collection
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
                                                    child: widget.eventId ==
                                                            widget
                                                                .similarEvents[
                                                                    index]
                                                                .id
                                                        ? const SizedBox()
                                                        : MoreLikeEventCard(
                                                            widget.similarEvents[
                                                                index])),
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
                  if (!widget.isLogged)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TransparentButtonNoIcon(
                            key: const Key("BuyTicketsBtn"),
                            'Log in',
                            logInNavigate,
                            false,
                            '${DateFormat('EEE, MMM d • hh:mmaaa ').format(widget.loadedEvent.startDate)} EET'),
                      ),
                    )
                  else if (widget.loadedEvent.endDate.toUtc().isBefore(
                          DateTime.now()
                              .add(const Duration(hours: 1))
                              .toUtc()) ||
                      (widget.eventFreeTickets.length +
                              widget.eventVipTickets.length) ==
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
