library BuyTicketsWidget;

import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_promocode.dart';
import 'placeorder.dart';
import 'transparent_button_no_icon.dart';
import '../models/event_ticket.dart';

class BuyTickets extends StatefulWidget {
  final String eventId;
  final String eventtitle;
  final String eventStartDate;
  List<EventTicketInfo> eventFreeTickets;
  List<EventTicketInfo> eventVipTickets;
  List<EventTicketInfo> eventFreeTicketsRender = [];
  List<EventTicketInfo> eventVipTicketsRender = [];
  List<EventPromocodeInfo> eventPromocodes = [];
  BuyTickets(this.eventId, this.eventtitle, this.eventStartDate,
      this.eventFreeTickets, this.eventVipTickets, this.eventPromocodes,
      {super.key});

  @override
  State<BuyTickets> createState() => _BuyTicketsState();
}

class SubmittedData {
  List<EventTicketInfo> reservedFreeTickets = [];
  List<EventTicketInfo> reservedVipTickets = [];
  String? promocodetId;
  double totalPrice = 0;
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
  SubmittedData data = SubmittedData();
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
  int allTicketSelectedQ = 0;

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
        // To Be: et2aked ena msh hat7tago hena
        // removePromoFromPrice();
      });

      /// Remove the data.promo value from submetted data
      data.promocodetId = null;
      return;
    }
    setState(() {
      // Entered value is valid so apply promocode
      promocodeApplied = true;
      applyPromoOnPrice();
    });

    /// PromoCheck: close Textfield
    // FocusScope.of(context).requestFocus(FocusNode());

    /// _fieldKey.currentState?.save(): save the value into submitted data class by calling onsave:
    _fieldKey.currentState?.save();
  }

  void applyPromoOnPrice() {
    // No VIP tickets to Apply this promo on it
    if (data.totalPrice == 0) {
      return;
    }

    EventPromocodeInfo? eventPromocode;
    for (int i = 0; i < widget.eventPromocodes.length; i++) {
      if (data.promocodetId == widget.eventPromocodes[i].id) {
        eventPromocode = widget.eventPromocodes[i];
      }
    }

    if (eventPromocode == null) {
      return;
    }

    // check on promocode type
    // if type Value
    if (!eventPromocode.isPercentage) {
      // if apply  and make sure that value is greater than zero after apply
      if (data.totalPrice - eventPromocode.discount > 0) {
        data.totalPrice = data.totalPrice - eventPromocode.discount;
        data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
        return;
      }
      // here promo code is greater than total price
      data.totalPrice = 0;
    }
    // if type percentage
    else {
      data.totalPrice = data.totalPrice * (1 - eventPromocode.discount);
      data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
    }
  }

  void removePromoFromPrice() {
    // check on promocode type
    EventPromocodeInfo? eventPromocode;
    for (int i = 0; i < widget.eventPromocodes.length; i++) {
      if (data.promocodetId == widget.eventPromocodes[i].id) {
        eventPromocode = widget.eventPromocodes[i];
      }
    }
    if (eventPromocode == null) {
      return;
    }

    // if type Value
    if (!eventPromocode.isPercentage) {
      // data.totalPrice =
      //     (data.vipTickets * widget.eventTickets.vipTicketPrice).toDouble();
      data.totalPrice = 0;
      for (int i = 0; i < data.reservedVipTickets.length; i++) {
        if (data.reservedVipTickets[i].selectedQuantity > 0) {
          data.totalPrice += data.reservedVipTickets[i].selectedQuantity *
              data.reservedVipTickets[i].ticketPrice;
        }
      }
      for (int i = 0; i < data.reservedFreeTickets.length; i++) {
        if (data.reservedFreeTickets[i].selectedQuantity > 0) {
          data.totalPrice += data.reservedFreeTickets[i].selectedQuantity *
              data.reservedFreeTickets[i].ticketPrice;
        }
      }
      data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
    }
    // if type percentage
    else {
      data.totalPrice = data.totalPrice / (1 - eventPromocode.discount);
      data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
    }
  }

  // --------------------------------------------- Tickets ---------------------------------------------------------
  void decrementFreeTickets(int ind) {
    if (promocodeApplied) {
      removePromoFromPrice();
    }
    if (data.reservedFreeTickets[ind].selectedQuantity > 0) {
      setState(() {
        --data.reservedFreeTickets[ind].selectedQuantity;
        --allTicketSelectedQ;
        data.totalPrice -= data.reservedFreeTickets[ind].ticketPrice;
        data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
        if (promocodeApplied) {
          applyPromoOnPrice();
        }
        if (data.reservedFreeTickets[ind].selectedQuantity == 0) {
          data.reservedFreeTickets.remove(data.reservedFreeTickets[ind]);
        }
      });
    }
  }

  void incrementFreeTickets(int ind) {
    // if applied before remove then apply
    if (promocodeApplied) {
      removePromoFromPrice();
    }
    if (data.reservedFreeTickets[ind].selectedQuantity <
        data.reservedFreeTickets[ind].avaliableQuantity) {
      setState(() {
        ++data.reservedFreeTickets[ind].selectedQuantity;
        ++allTicketSelectedQ;
        data.totalPrice += data.reservedFreeTickets[ind].ticketPrice;
        data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
        if (promocodeApplied) {
          applyPromoOnPrice();
        }
      });
    }
  }

  void decrementVipTickets(int ind) {
    // if applied before remove then apply
    if (promocodeApplied) {
      removePromoFromPrice();
    }
    if (data.reservedVipTickets[ind].selectedQuantity > 0) {
      setState(() {
        --data.reservedVipTickets[ind].selectedQuantity;
        --allTicketSelectedQ;
        data.totalPrice -= data.reservedVipTickets[ind].ticketPrice;
        data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
        if (promocodeApplied) {
          applyPromoOnPrice();
        }
        if (data.reservedVipTickets[ind].selectedQuantity == 0) {
          data.reservedVipTickets.remove(data.reservedVipTickets[ind]);
        }
      });
    }
  }

  void incrementVipTickets(int ind) {
    // if applied before remove then apply
    if (promocodeApplied) {
      removePromoFromPrice();
    }
    if (data.reservedVipTickets[ind].selectedQuantity <
        data.reservedVipTickets[ind].avaliableQuantity) {
      setState(() {
        ++data.reservedVipTickets[ind].selectedQuantity;
        ++allTicketSelectedQ;
        data.totalPrice += data.reservedVipTickets[ind].ticketPrice;
        data.totalPrice = ((data.totalPrice * 100).toInt()).toDouble() / (100);
        if (promocodeApplied) {
          applyPromoOnPrice();
        }
      });
    }
  }

  // --------------------------------------------- Form ---------------------------------------------------------
  // void purchase(BuildContext ctx, String promo, String totalPrice) {}

  /// Function to be called when checkout button is clicked
  void saveForm(BuildContext ctx, String eventId) {
    checkoutClicked = true;
    for (int i = 0; i < data.reservedFreeTickets.length; i++) {
      for (int j = 0; j < data.reservedFreeTickets[i].selectedQuantity; j++) {
        widget.eventFreeTicketsRender.add(data.reservedFreeTickets[i]);
      }
    }

    for (int i = 0; i < data.reservedVipTickets.length; i++) {
      for (int j = 0; j < data.reservedVipTickets[i].selectedQuantity; j++) {
        widget.eventVipTicketsRender.add(data.reservedVipTickets[i]);
      }
    }
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        enableDrag: false,
        builder: (_) {
          //------------------------ user input -------------------//
          return GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode());
            },
            behavior: HitTestBehavior.opaque,
            child: PlaceOrder(
                widget.eventId,
                widget.eventFreeTicketsRender,
                widget.eventVipTicketsRender,
                data.promocodetId,
                data.totalPrice),
          );
        });
  }

  // @override
  // void dispose() {
  //   data.promocodetId = null;
  //   data.reservedFreeTickets = [];
  //   data.reservedVipTickets = [];
  //   data.totalPrice = 0;
  //   promocodeApplied = false;
  //   checkoutClicked = false;
  //   allTicketSelectedQ = 0;
  //   super.dispose();
  // }

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
              // dispose();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushNamed(context, '/Event-Page',
                  arguments: {'eventId': widget.eventId, 'isLogged': '1'});
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
                    // if there is no promo code for this event OR no Vip tickets for the event
                    (widget.eventPromocodes.isEmpty ||
                            (widget.eventVipTickets.isEmpty &&
                                widget.eventFreeTickets.isEmpty))
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              key: _fieldKey,
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              //Validations
                              validator: (value) {
                                /// PromoCheck: check that promocode valid or no promocode entered
                                if (value == null) {
                                  return null;
                                }
                                for (int i = 0;
                                    i < widget.eventPromocodes.length;
                                    i++) {
                                  if (value == widget.eventPromocodes[i].name) {
                                    if (widget.eventPromocodes[i].startDate
                                        .isAfter(DateTime.now())) {
                                      return "Invalid promocode";
                                    }

                                    if ((widget.eventPromocodes[i].isLimited &&
                                            widget.eventPromocodes[i]
                                                    .availableAmount ==
                                                0) ||
                                        widget.eventPromocodes[i].endDate
                                            .isBefore(DateTime.now())) {
                                      return "Promocode expired";
                                    }
                                  }

                                  if (value.isEmpty ||
                                      value.length < 4 ||
                                      value == widget.eventPromocodes[i].name) {
                                    return null;
                                  }
                                }
                                if (checkoutClicked && !promocodeApplied) {
                                  return null;
                                }
                                return "Invalid promocode";
                              },

                              /// PromoCheck:Save value if valid and apply button clicked
                              onSaved: (newValue) {
                                for (int i = 0;
                                    i < widget.eventPromocodes.length;
                                    i++) {
                                  if (data.promocodetId ==
                                      widget.eventPromocodes[i].id) {
                                    data.promocodetId =
                                        widget.eventPromocodes[i].id;
                                  }
                                }
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
                                if (promocodeApplied == true) {
                                  // embedded remove check: check on list of vip tickets w 7ot values selected bs men 8er promomcode
                                  removePromoFromPrice();
                                }
                                promocodeApplied = false;

                                /// Remove the data.promo value from submitted data
                                data.promocodetId = null;
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
                    (widget.eventFreeTickets.isEmpty)
                        ? const SizedBox()
                        : Column(
                            children:
                                widget.eventFreeTickets.map((eventFreeTicket) {
                              if (eventFreeTicket.startDate
                                      .isAfter(DateTime.now()) &&
                                  eventFreeTicket.endDate
                                      .isBefore(DateTime.now())) {
                                return const SizedBox();
                              } else {
                                int index = data.reservedFreeTickets
                                    .indexOf(eventFreeTicket);
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 50, 100, 237)),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                        eventFreeTicket.name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      // No Added tickets from this ticket
                                                      index == -1
                                                          ? const IconButton(
                                                              onPressed: null,
                                                              icon: Icon(
                                                                  Icons
                                                                      .indeterminate_check_box,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218)),
                                                            )
                                                          : IconButton(
                                                              key: Key(
                                                                  'DecrementVipBtn${eventFreeTicket.id}'),
                                                              onPressed: () =>
                                                                  decrementFreeTickets(
                                                                      index),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .indeterminate_check_box,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                            ),
                                                      Text(
                                                          (index == -1)
                                                              ? '0'
                                                              : data
                                                                  .reservedFreeTickets[
                                                                      index]
                                                                  .selectedQuantity
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      (index != -1 &&
                                                              data
                                                                      .reservedFreeTickets[
                                                                          index]
                                                                      .selectedQuantity ==
                                                                  data
                                                                      .reservedFreeTickets[
                                                                          index]
                                                                      .avaliableQuantity)
                                                          ? const IconButton(
                                                              onPressed: null,
                                                              icon: Icon(
                                                                  Icons
                                                                      .add_box_rounded,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218)),
                                                            )
                                                          : IconButton(
                                                              key: Key(
                                                                  "IncrementFreeBtn${eventFreeTicket.id}"),
                                                              onPressed: () {
                                                                if (index ==
                                                                    -1) {
                                                                  setState(() {
                                                                    data.reservedFreeTickets
                                                                        .add(
                                                                            eventFreeTicket);
                                                                    index = data
                                                                        .reservedFreeTickets
                                                                        .indexOf(
                                                                            eventFreeTicket);
                                                                  });
                                                                }
                                                                incrementFreeTickets(
                                                                    index);
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .add_box_rounded,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                            ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          top: 10.0,
                                                          bottom: 20),
                                                  child: Text(
                                                      'Sales end on ${DateFormat('MMMM dd, yyyy').format(eventFreeTicket.endDate)}',
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromARGB(
                                                              255,
                                                              91,
                                                              90,
                                                              90))),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        eventFreeTicket
                                                            .ticketPrice
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Neue Plak Extended",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    51,
                                                                    51,
                                                                    51))),
                                                    const Text(' EGP',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Neue Plak Condensed",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    51,
                                                                    51,
                                                                    51))),
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
                                  ],
                                );
                              }
                            }).toList(),
                          ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Checks:
                    // 1. There is avliable tickets
                    // 2. Start selling date is after now
                    // 2. end selling date is before now
                    (widget.eventVipTickets.isEmpty)
                        ? const SizedBox()
                        : Column(
                            children:
                                widget.eventVipTickets.map((eventVipTicket) {
                              if (eventVipTicket.startDate
                                      .isAfter(DateTime.now()) ||
                                  eventVipTicket.endDate
                                      .isBefore(DateTime.now())) {
                                return const SizedBox();
                              } else {
                                int index = data.reservedVipTickets
                                    .indexOf(eventVipTicket);
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 50, 100, 237)),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                        eventVipTicket.name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      // No Added tickets from this ticket
                                                      index == -1
                                                          ? const IconButton(
                                                              onPressed: null,
                                                              icon: Icon(
                                                                  Icons
                                                                      .indeterminate_check_box,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218)),
                                                            )
                                                          : IconButton(
                                                              key: Key(
                                                                  'DecrementVipBtn${eventVipTicket.id}'),
                                                              onPressed: () =>
                                                                  decrementVipTickets(
                                                                      index),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .indeterminate_check_box,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                            ),
                                                      Text(
                                                          (index == -1)
                                                              ? '0'
                                                              : data
                                                                  .reservedVipTickets[
                                                                      index]
                                                                  .selectedQuantity
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      (index != -1 &&
                                                              data
                                                                      .reservedVipTickets[
                                                                          index]
                                                                      .selectedQuantity ==
                                                                  data
                                                                      .reservedVipTickets[
                                                                          index]
                                                                      .avaliableQuantity)
                                                          ? const IconButton(
                                                              onPressed: null,
                                                              icon: Icon(
                                                                  Icons
                                                                      .add_box_rounded,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          218,
                                                                          218)),
                                                            )
                                                          : IconButton(
                                                              key: Key(
                                                                  'IncrementVipBtn${eventVipTicket.id}'),
                                                              onPressed: () {
                                                                if (index ==
                                                                    -1) {
                                                                  setState(() {
                                                                    data.reservedVipTickets
                                                                        .add(
                                                                            eventVipTicket);
                                                                    index = data
                                                                        .reservedVipTickets
                                                                        .indexOf(
                                                                            eventVipTicket);
                                                                  });
                                                                }
                                                                incrementVipTickets(
                                                                    index);
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .add_box_rounded,
                                                                  size: 35,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                            ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          top: 10.0,
                                                          bottom: 5),
                                                  child: Text(
                                                      'Sales end on ${DateFormat('MMMM dd, yyyy').format(eventVipTicket.endDate)}',
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromARGB(
                                                              255,
                                                              91,
                                                              90,
                                                              90))),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        eventVipTicket
                                                            .ticketPrice
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Neue Plak Extended",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    51,
                                                                    51,
                                                                    51))),
                                                    const Text(' EGP',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Neue Plak Condensed",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    51,
                                                                    51,
                                                                    51))),
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
                                  ],
                                );
                              }
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
                                  overflow: TextOverflow.clip,
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
                              allTicketSelectedQ == 0,
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
