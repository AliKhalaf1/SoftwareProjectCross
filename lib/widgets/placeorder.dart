library PlaceOrderWidget;

import 'dart:async';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/widgets/buy_tickets.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helper_functions/event_promocode_info.dart';
import '../helper_functions/event_tickets_info.dart';
import '../helper_functions/place_order_api.dart';
import '../models/event_promocode.dart';
import '../screens/event_page.dart';
import 'loading_spinner.dart';
import 'transparent_button_no_icon.dart';
import '../models/event_ticket.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// {@category Widgets}
///
///StatefulWidget in Flutter, named PlaceOrder.
///
///It's used to display a form for placing an order for event tickets.
class PlaceOrder extends StatefulWidget {
  final String eventId;
  final String eventImg;
  final List<EventTicketInfo> reservedFreeTickets;
  final List<EventTicketInfo> reservedVipTickets;
  final String? promocodetId;
  final double totalPrice;
  const PlaceOrder(
      this.eventId,
      this.reservedFreeTickets,
      this.reservedVipTickets,
      this.promocodetId,
      this.totalPrice,
      this.eventImg,
      {super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class SubmittedData {
  //constants
  List<EventTicketInfo> reservedFreeTickets = [];
  List<EventTicketInfo> reservedVipTickets = [];
  String promocodetId = "";
  double totalPrice = 0;
  String email = '';
  String creationDate =
      DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
  // changed
  String firstName = '';
  String lastname = '';
  List<String> fnamesFree = [];
  List<String> lnamesFree = [];
  List<String> emailsFree = [];
  List<String> fnamesVip = [];
  List<String> lnamesVip = [];
  List<String> emailsVip = [];
}

class _PlaceOrderState extends State<PlaceOrder> {
//**************************************************************************************************************** */
//--========================================= Controllers of the form =========================================--
//--================================================== variables ==============================================--
//**************************************************************************************************************** */

  final _form = GlobalKey<FormState>();
  final firstNameInp = TextEditingController();
  final lastNameInp = TextEditingController();
  SubmittedData data = SubmittedData();

  //------------------ Timer ----------------
  int _seconds = 0;
  int _minutes = 30;
  Timer? _timer;

//------------------ which to show ----------------
// 0: checkout
// 1: Leave
// 2: timeout
  int screen = 0;

  bool isloading = false;

//--================================================== Methods ==============================================--
//**************************************************************************************************************** */

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Leave Checkout'),
          content: const Text(
              'Are you sure you want to leave checkOut? The items you\'ve selected may not be available later.'),
          actions: [
            TextButton(
              child: Text('Leave',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Map<String, dynamic> args = {
                  'eventId': widget.eventId,
                  'isLogged': "1",
                  'eventIdMock': 0,
                };
                Navigator.of(context).popUntil((route) => route.isFirst);
                //Navigator.popUntil(context, ModalRoute.withName("/search"));
                Navigator.of(context).pushNamed(
                  EventPage.eventPageRoute,
                  arguments: args,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showSessionTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Session Timeout'),
          content: const Text(
              'Your reservation has been released. please re-start your purchase.'),
          actions: [
            TextButton(
              child: Text('Back to Event',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Map<String, dynamic> args = {
                  'eventId': widget.eventId,
                  'isLogged': "1",
                  'eventIdMock': 0,
                };
                Navigator.of(context).popUntil((route) => route.isFirst);
                //Navigator.popUntil(context, ModalRoute.withName("/search"));
                Navigator.of(context).pushNamed(
                  EventPage.eventPageRoute,
                  arguments: args,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showFail(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order failed'),
          content: const Text('Faild to place your order'),
          actions: [
            TextButton(
              child: Text('Back to Event',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                stopTimer();
                Map<String, dynamic> args = {
                  'eventId': widget.eventId,
                  'isLogged': "1",
                  'eventIdMock': 0,
                };
                Navigator.of(context).popUntil((route) => route.isFirst);
                //Navigator.popUntil(context, ModalRoute.withName("/search"));
                Navigator.of(context).pushNamed(
                  EventPage.eventPageRoute,
                  arguments: args,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Audio functions
  final player = AudioPlayer();

  void playSound() async {
    await player.play(AssetSource('sounds/placeorder.mp4'));
    await player.onPlayerComplete.first;
    await player.stop();
  }

  // Timer functions
  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_seconds == 0 && _minutes == 0) {
            // Handle Time out
            stopTimer();
            showSessionTimeoutDialog(context);
          } else if (_seconds == 0) {
            _seconds = 59;
            _minutes--;
          } else {
            _seconds--;
          }
        },
      ),
    );
  }

  /// Function to be called when checkout button is clicked
  void saveForm(BuildContext ctx, String eventId) async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      isloading = true;
    });
    // ====================== call Apis =====================
    String orderId;
    await postOrder(eventId, data.firstName, data.lastname, data.email,
            data.creationDate, data.totalPrice.toInt(), widget.eventImg)
        .then((value) async {
      if (value == "1000") {
        print('order fail');
        print(data.creationDate);
        print(
            "++++++++++++++++++//////////////////////////////////++++++++++++++++++++");
        showFail(context);
        return;
      } else {
        orderId = value;
        for (int i = 0; i < data.reservedFreeTickets.length; i++) {
          await postEventTicketInfo(data.reservedFreeTickets[i].id,
                  data.reservedFreeTickets[i].selectedQuantity)
              .then((value) {
            if (!value) {
              print(
                  "------------------------------//////////////////////////////////------------------");
              print('free tick fail');
              showFail(context);
              return;
            }
          });
        }
        for (int i = 0; i < data.reservedVipTickets.length; i++) {
          await postEventTicketInfo(data.reservedVipTickets[i].id,
                  data.reservedVipTickets[i].selectedQuantity)
              .then((value) {
            if (!value) {
              print("------------------------------------------------");
              print('vip tick fail');
              showFail(context);
              return;
            }
          });
        }
        for (int i = 0; i < data.fnamesFree.length; i++) {
          await addAtendee(
            data.fnamesFree[i],
            data.lnamesFree[i],
            data.emailsFree[i],
            "regular",
            orderId,
            eventId,
          ).then((value) {
            if (!value) {
              print('free Atendee fail');
              print(
                  "***********************Freeeeeeeeee*************************************");
              showFail(context);
              return;
            }
          });
        }
        for (int i = 0; i < data.fnamesVip.length; i++) {
          await addAtendee(
            data.fnamesVip[i],
            data.lnamesVip[i],
            data.emailsVip[i],
            "vip",
            orderId,
            eventId,
          ).then((value) {
            if (!value) {
              print('vip Atendee fail');
              print(
                  "***********************Viiiiiiiiiiiiiiiiiiip*************************************");
              showFail(context);
              return;
            }
          });
        }
        if (data.promocodetId == "") {
          print('sucess');
          // ====================== navigate ======================
          // To Be:
          stopTimer();
          playSound();

          Map<String, dynamic> args = {
            'eventId': widget.eventId,
            'isLogged': "1",
            'eventIdMock': 0,
          };
          Navigator.of(context).popUntil((route) => route.isFirst);
          //Navigator.popUntil(context, ModalRoute.withName("/search"));
          Navigator.of(context).pushNamed(
            EventPage.eventPageRoute,
            arguments: args,
          );
        } else {
          await postEventPrmocodeInfo(data.promocodetId).then((value) {
            if (!value) {
              print('Promo fail');
              print(
                  "***********************Promoooooooooooooo*************************************");
              showFail(context);
            } else {
              print('sucess');
              // ====================== navigate ======================
              // To Be:
              stopTimer();
              playSound();

              Map<String, dynamic> args = {
                'eventId': widget.eventId,
                'isLogged': "1",
                'eventIdMock': 0,
              };
              Navigator.of(context).popUntil((route) => route.isFirst);
              //Navigator.popUntil(context, ModalRoute.withName("/search"));
              Navigator.of(context).pushNamed(
                EventPage.eventPageRoute,
                arguments: args,
              );
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  void initState() {
    getEmail().then((value) => data.email = value);
    if (widget.promocodetId == null) {
      data.promocodetId = "";
    } else {
      data.promocodetId = widget.promocodetId!;
    }
    data.reservedFreeTickets = widget.reservedFreeTickets;
    data.reservedVipTickets = widget.reservedVipTickets;
    data.totalPrice = widget.totalPrice;
    data.fnamesFree = List.filled(widget.reservedFreeTickets.length, '');
    data.lnamesFree = List.filled(widget.reservedFreeTickets.length, '');
    data.emailsFree = List.filled(widget.reservedFreeTickets.length, '');
    data.fnamesVip = List.filled(widget.reservedVipTickets.length, '');
    data.lnamesVip = List.filled(widget.reservedVipTickets.length, '');
    data.emailsVip = List.filled(widget.reservedVipTickets.length, '');
    print(data.totalPrice);
    print(data.promocodetId);

    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("PlaceOrderModal"),
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Checkout',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'Time left: $_minutes:${_seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: _minutes < 6
                        ? const Color.fromARGB(255, 204, 52, 41)
                        : const Color.fromARGB(255, 119, 118, 118),
                  )),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => showConfirmationDialog(context),
            icon: const Icon(Icons.close, size: 15),
          ),
        ],
      ),
      body: isloading
          ? const LoadingSpinner()
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: const Color.fromARGB(255, 255, 72, 0),
              child: ListView(children: <Widget>[
                Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Form(
                    key: _form,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 10),
                              child: const Text(
                                'Billing information',
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
                            child: Column(
                              children: [
                                // ---------------------------- first and last names -----------------------------------------------
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 80,
                                        padding: const EdgeInsets.only(top: 10),
                                        child: TextFormField(
                                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //Validations
                                          validator: (value) {
                                            /// PromoCheck: check that promocode valid or no promocode entered
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Enter your first name";
                                            }
                                            return null;
                                          },

                                          /// Save first name
                                          onSaved: (newValue) {
                                            data.firstName = newValue!;
                                          },
                                          cursorColor: const Color.fromARGB(
                                              255, 50, 100, 237),
                                          maxLength: 10,
                                          style: const TextStyle(),
                                          decoration: const InputDecoration(
                                              hintText: "Enter fname",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              floatingLabelStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 50, 100, 237)),
                                              labelText: 'First name',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 50, 100, 237),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              )),
                                          controller: firstNameInp,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 80,
                                        margin: const EdgeInsets.all(0),
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 0),
                                        child: TextFormField(
                                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //Validations

                                          validator: (value) {
                                            /// PromoCheck: check that promocode valid or no promocode entered
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Enter your last name";
                                            }
                                            return null;
                                          },

                                          /// Save first name
                                          onSaved: (newValue) {
                                            data.lastname = newValue!;
                                          },
                                          cursorColor: const Color.fromARGB(
                                              255, 50, 100, 237),
                                          maxLength: 10,
                                          style: const TextStyle(),
                                          decoration: const InputDecoration(
                                              hintText: "Enter lname",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              floatingLabelStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 50, 100, 237)),
                                              labelText: 'Last name',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 50, 100, 237),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              )),
                                          controller: lastNameInp,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                // ---------------------------- Email -----------------------------------------------
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 80,
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    enabled: false,
                                    cursorColor:
                                        const Color.fromARGB(255, 77, 77, 77),
                                    // maxLength: 10,
                                    decoration: InputDecoration(
                                        filled: true,
                                        // MaxLines: null,
                                        fillColor: const Color.fromARGB(
                                            255, 245, 245, 245),
                                        floatingLabelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 77, 77, 77)),
                                        hintText: data.email,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Email Address',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0)),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          // ----------------------------------------- Tickets Info ----------------------------------------
                          data.reservedFreeTickets.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: data.reservedFreeTickets
                                      .map((eventFreeTicket) {
                                    int index = data.reservedFreeTickets
                                        .indexOf(eventFreeTicket);
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                right: 15, bottom: 10),
                                            child: Text(
                                              'Ticket${index + 1} • ${eventFreeTicket.name}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  height: 1.2,
                                                  letterSpacing: 1.3,
                                                  fontFamily:
                                                      'Neue Plak Extended',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      17, 3, 59, 1)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 80,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: TextFormField(
                                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  //Validations
                                                  validator: (value) {
                                                    /// PromoCheck: check that promocode valid or no promocode entered
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Enter ticket owner first name";
                                                    }
                                                    return null;
                                                  },

                                                  /// Save first name
                                                  onSaved: (newValue) {
                                                    data.fnamesFree[index] =
                                                        newValue!;
                                                  },
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 50, 100, 237),
                                                  maxLength: 10,
                                                  style: const TextStyle(),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter fname",
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          floatingLabelStyle:
                                                              TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                          labelText:
                                                              'First name',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      100,
                                                                      237),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 80,
                                                margin: const EdgeInsets.all(0),
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 0),
                                                child: TextFormField(
                                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  //Validations

                                                  validator: (value) {
                                                    /// PromoCheck: check that promocode valid or no promocode entered
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Enter ticket owner last name";
                                                    }
                                                    return null;
                                                  },

                                                  /// Save first name
                                                  onSaved: (newValue) {
                                                    data.lnamesFree[index] =
                                                        newValue!;
                                                  },
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 50, 100, 237),
                                                  maxLength: 10,
                                                  style: const TextStyle(),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter lname",
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          floatingLabelStyle:
                                                              TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                          labelText:
                                                              'Last name',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      100,
                                                                      237),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ---------------------------- Email -----------------------------------------------
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 80,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                                            //Validations
                                            validator: (value) {
                                              /// PromoCheck: check that promocode valid or no promocode entered
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter ticket owner email";
                                              }
                                              if (!EmailValidator.validate(
                                                  value)) {
                                                return "Enter valid email";
                                              }
                                              return null;
                                            },

                                            /// Save first name
                                            onSaved: (newValue) {
                                              data.emailsFree[index] =
                                                  newValue!;
                                            },
                                            cursorColor: const Color.fromARGB(
                                                255, 50, 100, 237),
                                            maxLength: 50,
                                            style: const TextStyle(),
                                            decoration: const InputDecoration(
                                                hintText: "Enter email",
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                floatingLabelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 50, 100, 237)),
                                                labelText: 'email',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 50, 100, 237),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(0)),
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),

                          data.reservedVipTickets.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: data.reservedVipTickets
                                      .map((eventVipTicket) {
                                    int index = data.reservedVipTickets
                                        .indexOf(eventVipTicket);
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                right: 15, bottom: 10),
                                            child: Text(
                                              'Ticket${widget.reservedFreeTickets.length + index + 1} • ${eventVipTicket.name}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  height: 1.2,
                                                  letterSpacing: 1.3,
                                                  fontFamily:
                                                      'Neue Plak Extended',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      17, 3, 59, 1)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 80,
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: TextFormField(
                                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  //Validations
                                                  validator: (value) {
                                                    /// PromoCheck: check that promocode valid or no promocode entered
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Enter ticket owner first name";
                                                    }
                                                    return null;
                                                  },

                                                  /// Save first name
                                                  onSaved: (newValue) {
                                                    data.fnamesVip[index] =
                                                        newValue!;
                                                  },
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 50, 100, 237),
                                                  maxLength: 10,
                                                  style: const TextStyle(),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter fname",
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          floatingLabelStyle:
                                                              TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                          labelText:
                                                              'First name',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      100,
                                                                      237),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 80,
                                                margin: const EdgeInsets.all(0),
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 0),
                                                child: TextFormField(
                                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  //Validations

                                                  validator: (value) {
                                                    /// PromoCheck: check that promocode valid or no promocode entered
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Enter ticket owner last name";
                                                    }
                                                    return null;
                                                  },

                                                  /// Save first name
                                                  onSaved: (newValue) {
                                                    data.lnamesVip[index] =
                                                        newValue!;
                                                  },
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 50, 100, 237),
                                                  maxLength: 10,
                                                  style: const TextStyle(),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter lname",
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          floatingLabelStyle:
                                                              TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                          labelText:
                                                              'Last name',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      100,
                                                                      237),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            0)),
                                                          )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ---------------------------- Email -----------------------------------------------
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 80,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                                            //Validations
                                            validator: (value) {
                                              /// PromoCheck: check that promocode valid or no promocode entered
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter ticket owner email";
                                              }
                                              if (!EmailValidator.validate(
                                                  value)) {
                                                return "Enter valid email";
                                              }
                                              return null;
                                            },

                                            /// Save first name
                                            onSaved: (newValue) {
                                              data.emailsVip[index] = newValue!;
                                            },
                                            cursorColor: const Color.fromARGB(
                                                255, 50, 100, 237),
                                            maxLength: 50,
                                            style: const TextStyle(),
                                            decoration: const InputDecoration(
                                                hintText: "Enter email",
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                floatingLabelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 50, 100, 237)),
                                                labelText: 'email',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(0)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 50, 100, 237),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(0)),
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('Powered by ',
                                    style: TextStyle(
                                        fontFamily: "Neue Plak",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 92, 92, 92))),
                                Text('Borto',
                                    style: TextStyle(
                                        fontFamily: "Neue Plak Text",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 88, 88, 88))),
                                Image(
                                  image: AssetImage("assets/images/icon.png"),
                                  width: 17,
                                  height: 17,
                                ),
                                Text('an ',
                                    style: TextStyle(
                                        fontFamily: "Neue Plak Text",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 88, 88, 88))),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //--------------------------------------- Check out button --------------------------------------------------------
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.credit_card,
                                      color: Color.fromARGB(255, 50, 100, 237),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(data.totalPrice.toString(),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            fontFamily: "Neue Plak Extended",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 51, 51, 51))),
                                    const Text(' EGP',
                                        style: TextStyle(
                                            fontFamily: "Neue Plak Condensed",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 51, 51, 51))),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: TransparentButtonNoIcon(
                                    key: const Key("PlaceOrder"),
                                    'Place order',
                                    saveForm,
                                    false,
                                    widget.eventId,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}
