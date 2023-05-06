library BuyTicketsWidget;

import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_promocode.dart';
import 'transparent_button_no_icon.dart';
import '../models/event_tickets.dart';

class BuyTickets extends StatefulWidget {
  final String eventId;
  final String eventtitle;
  final String eventStartDate;
  final EventTicketsInfo eventTickets;
  final EventPromocodeInfo? eventPromocode;
  const BuyTickets(this.eventId, this.eventtitle, this.eventStartDate,
      this.eventTickets, this.eventPromocode,
      {super.key});

  @override
  State<BuyTickets> createState() => _BuyTicketsState();
}

class SubmittedData {
  String? promo;
  // Ids to access apis with it
  // To Be: shoof hatstlmhm feen
  //-------------------//
  String? freeTicketId;
  String? vipTicketId;
  String? promocodetId;
  //-------------------//
  int freeTickets = 0;
  int vipTickets = 0;
  int totalPrice = 0;
}

class _BuyTicketsState extends State<BuyTickets> {
//**************************************************************************************************************** */
//--========================================= Controllers of the form =========================================--
//--================================================== variables ==============================================--
//**************************************************************************************************************** */

  // --------------------------------------------- Promocode ---------------------------------------------------------
  //Promo code input
  final promoCodeInp = TextEditingController();
  bool _showSuffixIcon = false;
  final data = SubmittedData();
  final _form = GlobalKey<FormState>();
  final _fieldKey = GlobalKey<FormFieldState>();

  /// Promocode checks idea
  /// promocodes alwyas checked in validator
  /// PromoCheck: validator called when press on apply iconBtn
  /// PromoCheck: Apply canceled when tab on field again
  /// promocodeApplied: boolean check if promocode applied or not
  /// checkoutClicked: boolean to be true only if checkout Btn clicked
  bool promocodeApplied = false;
  bool checkoutClicked = false;

  // --------------------------------------------- Tickets ---------------------------------------------------------

//--================================================== Methods ==============================================--
//**************************************************************************************************************** */

  // --------------------------------------------- Promocode ---------------------------------------------------------
  /// Call validator of the textformfield and checks if promocode is valid whenpress on Btn
  void addPromoCode() {
    final isValid = _fieldKey.currentState?.validate();
    if (!isValid!) {
      setState(() {
        // Entered value is not valid so Not to apply promocode
        promocodeApplied = false;
      });

      /// Remove the data.promo value from submetted data
      data.promo = null;
      return;
    }
    setState(() {
      // Entered value is valid so apply promocode
      promocodeApplied = true;
    });

    /// PromoCheck: close Textfield
    FocusScope.of(context).requestFocus(FocusNode());

    /// _fieldKey.currentState?.save(): save the value into submitted data class by calling onsave:
    _fieldKey.currentState?.save();
  }

  // --------------------------------------------- Tickets ---------------------------------------------------------
  void decrementFreeTickets() {
    if (data.freeTickets > 0) {
      setState(() {
        --data.freeTickets;
      });
    }
  }

  void incrementFreeTickets() {
    if (data.freeTickets < widget.eventTickets.avaliableQuantaties[0]) {
      setState(() {
        ++data.freeTickets;
      });
    }
  }

  void decrementVipTickets() {
    if (data.vipTickets > 0) {
      setState(() {
        --data.vipTickets;
        data.totalPrice -= widget.eventTickets.vipTicketPrice;
      });
    }
  }

  void incrementVipTickets() {
    if (data.vipTickets < widget.eventTickets.avaliableQuantaties[1]) {
      setState(() {
        ++data.vipTickets;
        data.totalPrice += widget.eventTickets.vipTicketPrice;
      });
    }
  }

  // --------------------------------------------- Form ---------------------------------------------------------
  // void purchase(BuildContext ctx, String promo, String totalPrice) {}

  /// Function to be called when checkout button is clicked
  void saveForm(BuildContext ctx, String eventId) {
    checkoutClicked = true;
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();

    print('Data is: ');
    print(data.promo);
    print(data.freeTickets);
    print(data.vipTickets);
    print(data.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("BuyTicketsModal"),
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
              Text(widget.eventtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(widget.eventStartDate,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 119, 118, 118))),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, size: 15),
          ),
        ],
      ),
      body: GlowingOverscrollIndicator(
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
                    // --------------------------------------- Promo-code ------------------------------------------------------------
                    // if there is no promo code for this event or no Vip tickets for the event
                    (widget.eventPromocode == null ||
                            widget.eventPromocode!.avliableAmount == 0 ||
                            widget.eventTickets.avaliableQuantaties[1] == 0)
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              key: _fieldKey,
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              //Validations
                              validator: (value) {
                                /// PromoCheck: check that promocode validation or no promocode entered
                                if (value == null) {
                                  return null;
                                }
                                if (value.isEmpty ||
                                    value.length < 4 ||
                                    value == widget.eventPromocode!.name) {
                                  return null;
                                }
                                if (checkoutClicked && !promocodeApplied) {
                                  return null;
                                }
                                return "Invalid promocode";
                              },

                              /// PromoCheck:Save value if valid and apply button clicked
                              onSaved: (newValue) {
                                data.promo = newValue;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 50, 100, 237),
                              maxLength: 10,
                              style: const TextStyle(),
                              decoration: InputDecoration(
                                  hintText: "Enter code",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  floatingLabelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 50, 100, 237)),
                                  //Apply button
                                  suffixIcon: _showSuffixIcon
                                      ? promocodeApplied
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Color.fromARGB(
                                                  255, 16, 191, 22),
                                            )
                                          : IconButton(
                                              key: const Key(
                                                  'ApplyPromocodeBtn'),
                                              icon: const Icon(
                                                  Icons.check_circle),
                                              onPressed: addPromoCode,
                                              color: const Color.fromARGB(
                                                  255, 50, 100, 237),
                                            )
                                      : const IconButton(
                                          // key: Key('ApplyPromocodeBtn'),
                                          icon: Icon(
                                            Icons.check_circle,
                                            color: Color.fromARGB(
                                                255, 218, 218, 218),
                                          ),

                                          onPressed: null,
                                        ),
                                  labelText: 'Promo Code',
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  )),
                              controller: promoCodeInp,

                              /// PromoCheck: check with every change of textfield
                              onChanged: (value) {
                                ///Check on length of the text to determine show the apply icon or not
                                setState(() {
                                  _showSuffixIcon = (value.length > 3);
                                });
                              },

                              /// PromoCheck: Cancel apply if user tap on textfield again
                              onTap: () {
                                promocodeApplied = false;

                                /// Remove the data.promo value from submetted data
                                data.promo = null;
                              },
                            ),
                          ),

                    const SizedBox(
                      height: 20,
                    ),

                    // --------------------------------------- Tickets ------------------------------------------------------------
                    // Checks:
                    // 1. There is avliable tickets
                    // 2. Start selling date is before now
                    // 2. end selling date is after now
                    (widget.eventTickets.avaliableQuantaties[0] == 0 &&
                            widget.eventTickets.startDates[0]
                                .isBefore(DateTime.now()) &&
                            widget.eventTickets.endDates[0]
                                .isAfter(DateTime.now()))
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 50, 100, 237)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  margin: const EdgeInsets.all(0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text("Free Tickets",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            data.freeTickets == 0
                                                ? const IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                        Icons
                                                            .indeterminate_check_box,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255,
                                                            218,
                                                            218,
                                                            218)),
                                                  )
                                                : IconButton(
                                                    key: const Key(
                                                        "DecrementFreeBtn"),
                                                    onPressed:
                                                        decrementFreeTickets,
                                                    icon: const Icon(
                                                        Icons
                                                            .indeterminate_check_box,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 50, 100, 237)),
                                                  ),
                                            Text(data.freeTickets.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            data.freeTickets ==
                                                    widget.eventTickets
                                                        .avaliableQuantaties[0]
                                                ? const IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                        Icons.add_box_rounded,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255,
                                                            218,
                                                            218,
                                                            218)),
                                                  )
                                                : IconButton(
                                                    key: const Key(
                                                        "IncrementFreeBtn"),
                                                    onPressed:
                                                        incrementFreeTickets,
                                                    icon: const Icon(
                                                        Icons.add_box_rounded,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 50, 100, 237)),
                                                  ),
                                          ],
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0, bottom: 20),
                                        child: Text(
                                            'Sales end on ${DateFormat('MMMM dd, yyyy').format(widget.eventTickets.endDates[0])}',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 91, 90, 90))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Checks:
                    // 1. There is avliable tickets
                    // 2. Start selling date is before now
                    // 2. end selling date is after now
                    (widget.eventTickets.avaliableQuantaties[1] == 0 &&
                            widget.eventTickets.startDates[1]
                                .isBefore(DateTime.now()) &&
                            widget.eventTickets.endDates[1]
                                .isAfter(DateTime.now()))
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 50, 100, 237)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  margin: const EdgeInsets.all(0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text("Vip Tickets",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            data.vipTickets == 0
                                                ? const IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                        Icons
                                                            .indeterminate_check_box,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255,
                                                            218,
                                                            218,
                                                            218)),
                                                  )
                                                : IconButton(
                                                    key: const Key(
                                                        "DecrementVipBtn"),
                                                    onPressed:
                                                        decrementVipTickets,
                                                    icon: const Icon(
                                                        Icons
                                                            .indeterminate_check_box,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 50, 100, 237)),
                                                  ),
                                            Text(data.vipTickets.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            data.vipTickets ==
                                                    widget.eventTickets
                                                        .avaliableQuantaties[1]
                                                ? const IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                        Icons.add_box_rounded,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255,
                                                            218,
                                                            218,
                                                            218)),
                                                  )
                                                : IconButton(
                                                    key: const Key(
                                                        "IncrementVipBtn"),
                                                    onPressed:
                                                        incrementVipTickets,
                                                    icon: const Icon(
                                                        Icons.add_box_rounded,
                                                        size: 35,
                                                        color: Color.fromARGB(
                                                            255, 50, 100, 237)),
                                                  ),
                                          ],
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 10.0, bottom: 5),
                                        child: Text(
                                            'Sales end on ${DateFormat('MMMM dd, yyyy').format(widget.eventTickets.endDates[1])}',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 91, 90, 90))),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              widget.eventTickets.vipTicketPrice
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily:
                                                      "Neue Plak Extended",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51))),
                                          const Text(' EGP',
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Neue Plak Condensed",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                    const SizedBox(
                      height: 20,
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
                                  color: Color.fromARGB(255, 92, 92, 92))),
                          Text('Borto',
                              style: TextStyle(
                                  fontFamily: "Neue Plak Text",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 88, 88, 88))),
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
                                  color: Color.fromARGB(255, 88, 88, 88))),
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
                                  style: const TextStyle(
                                      fontFamily: "Neue Plak Extended",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 51, 51, 51))),
                              const Text(' EGP',
                                  style: TextStyle(
                                      fontFamily: "Neue Plak Condensed",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 51, 51, 51))),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: TransparentButtonNoIcon(
                              key: const Key("CheckoutBtn"),
                              'Check out',
                              saveForm,
                              data.freeTickets + data.vipTickets == 0,
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
    ;
  }
}

class EventTicketsInf {}
