library BuyTicketsWidget;

import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:flutter/material.dart';
import 'transparent_button_no_icon.dart';

class BuyTickets extends StatefulWidget {
  final String eventId;
  final String eventtitle;
  final String eventStartDate;
  const BuyTickets(this.eventId, this.eventtitle, this.eventStartDate,
      {super.key});

  @override
  State<BuyTickets> createState() => _BuyTicketsState();
}

class SubmittedData {
  String? promo;
  String? price;
}

class _BuyTicketsState extends State<BuyTickets> {
// ---------------------- variables -----------------------
//-- Controllers of the form --
  //Promo code input
  final promoCodeInp = TextEditingController();
  bool _showSuffixIcon = false;
  final data = SubmittedData();
  final _form = GlobalKey<FormState>();
  final _fieldKey = GlobalKey<FormFieldState>();

  // Promocode valid code
  // validPromocode could be nullable as api can return null
  // To Be: Get it from API return promocode valid for this event (it takes eventId)
  // To Be: remove intialization value
  String? validPromocode = '1234';

  // Promocode checks idea
  // promocodes regulartly checked in validator
  /// PromoCheck: validator called when press on apply iconBtn 
  /// PromoCheck: Apply canceled when tab on field again
  /// promocodeApplied: boolean check if promocode applied or not
  /// checkoutClicked: boolean to be true only if checkout Btn clicked
  bool promocodeApplied =
      false;
  bool checkoutClicked = false;

// ---------------------- Method -----------------------
  /// Call validator of the textformfield and checks if promocode is valid whenpress on Btn
  void addPromoCode() {
    final isValid = _fieldKey.currentState?.validate();
    if (!isValid!) {
      setState(() {
        // Entered value is not valid so Not to apply promocode
        promocodeApplied = false;
      });
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

  void purchase(BuildContext ctx, String promo, String price) {}
  void saveForm(BuildContext ctx, String eventId) {
    checkoutClicked = true;
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
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
      body: Card(
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
                validPromocode == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          key: _fieldKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          //Validations
                          validator: (value) {
                            /// PromoCheck: check that promocode validation or no promocode entered
                            if (value == null) {
                              return null;
                            }
                            if (value.isEmpty ||
                                value.length < 4 ||
                                value == validPromocode) {
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
                          cursorColor: Theme.of(context).primaryColor,
                          maxLength: 10,
                          style: const TextStyle(),
                          decoration: InputDecoration(
                              hintText: "Enter code",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              //Apply button
                              suffixIcon: _showSuffixIcon
                                  ? promocodeApplied
                                      ? const Icon(
                                          Icons.check_circle,
                                          color:
                                              Color.fromARGB(255, 16, 191, 22),
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.check_circle),
                                          onPressed: addPromoCode,
                                          color: Theme.of(context).primaryColor,
                                        )
                                  : const IconButton(
                                      key: Key('ApplyPromocodeBtn'),
                                      icon: Icon(Icons.check_circle),
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
                          },
                        ),
                      ),

                const SizedBox(
                  height: 20,
                ),

                // --------------------------------------- Promo-code ------------------------------------------------------------

                //--------------------------------------- Check out button --------------------------------------------------------
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TransparentButtonNoIcon(
                        key: const Key("CheckoutBtn"),
                        'Check out',
                        saveForm,
                        false,
                        widget.eventId,
                        '',
                        ''),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
