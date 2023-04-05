library FiltersScreen;

import 'package:flutter/material.dart';
import '../models/tags.dart';
import '../widgets/check_box.dart';
import '../widgets/filter_categ.dart';
import '../widgets/radio_button.dart';
import '../widgets/title_text_1.dart';
import '../widgets/transparent_button_no_icon.dart';
import 'tab_bar.dart';

class FilterScreen extends StatefulWidget {
  //-----------------------------------------------------------//
  //                   status variables                       //
  // to be obtained from local data-base                     //
  List<Tag> selectedTags; /* Selected Tags */
  int selectedValue =
      0; /* selected value of Sort by #(to be substituted by local variable from the local data base)#*/
  bool isCheckedPrice = false; /* Checked value #*/
  bool isCheckedOrganizer = false; /* Checked value #*/
  bool applyBtnState = false; /* Variable to know activate button or not #*/

  //-----------------------------------------------------------//

  FilterScreen(this.selectedTags, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //---------------- Variables ---------------//

  //---------------- Methods -----------------//
  //Apply filters
  void applyFilters(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Search', tabBarIndex: 1);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: TitleText1('Filters'),
        ),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          //Stack 1st child
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.orange.shade900,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: 1, // substitute with collectionCounts
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterCateg('Date', 'Anytime', widget.applyBtnState),
                        FilterCateg('Location', 'Online', widget.applyBtnState),
                        FilterCateg(
                            'Category', 'Anything', widget.applyBtnState),
                        CheckBox('Price', 'Free stuff only',
                            widget.isCheckedPrice, widget.applyBtnState),
                        CheckBox('Organiser', 'From organizers you follow',
                            widget.isCheckedOrganizer, widget.applyBtnState),
                        RadioButton(widget.selectedValue, widget.applyBtnState),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          //Stack 2nd child
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TransparentButtonNoIcon(
                  'Apply filters (${widget.selectedTags.length})',
                  applyFilters,
                  widget.applyBtnState),
            ),
          )
        ],
      ),
    );
  }
}
