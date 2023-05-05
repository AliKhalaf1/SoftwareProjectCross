library FiltersScreen;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filters/filter_selection_values.dart';
import '../providers/filters/tag.dart';
import '../providers/filters/tags.dart';
import '../providers/filters/temp_selected_filter_values.dart';
import '../providers/filters/temp_tags.dart';
import '../widgets/check_box.dart';
import '../widgets/filter_categ.dart';
import '../widgets/radio_button.dart';
import '../widgets/title_text_1.dart';
import '../widgets/transparent_button_no_icon.dart';
import 'tab_bar.dart';
import 'package:http/http.dart' as http;

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the diffrent filters when searching for an event.
///

class FilterScreen extends StatefulWidget {
  //-----------------------------------------------------------//
  //                        Button satatus                   //
  bool applyBtnState = false; /* Variable to know activate button or not #*/

  //-----------------------------------------------------------//

  static const filtersPageRout = '/filters';

  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //---------------- Methods -----------------//
  //Apply filters
  void applyFilters(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Search', tabBarIndex: 1);
    }));
  }

  @override
  Widget build(BuildContext context) {
    //---------------- Variables ---------------//
    final tagsData = Provider.of<Tags>(context);
    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

    final tempTagsData = Provider.of<TemporaryTags>(context);
    final tempFiltersDataValues =
        Provider.of<TempFilterSelectionValues>(context);

    return Scaffold(
      key: const Key("FitersScreen"),
      appBar: AppBar(
        leading: IconButton(
          key: const Key("GoBackBtn"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            tagsData.setAll(tempTagsData);
            filtersDataValues.setAll(tempFiltersDataValues);
            // Navigator.pop(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
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
                        const FilterCateg(key: Key("DateFilter"), 0, 'Date'),
                        const FilterCateg(
                            key: Key("LocationFilter"), 1, 'Location'),
                        const FilterCateg(
                            key: Key("CategoreyFilter"), 2, 'Category'),
                        CheckBox(
                            key: const Key("PriceCheckBox"),
                            'Price',
                            'Free stuff only',
                            widget.applyBtnState),
                        // CheckBox(
                        //     key: const Key("OragnizerCheckBox"),
                        //     'Organiser',
                        //     'From organizers you follow',
                        // widget.applyBtnState),
                        // RadioButton(
                        //     key: const Key("SortByRadioBtns"),
                        //     widget.applyBtnState),
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
                  key: const Key("ApplyFiltersBtn"),
                  'Apply filters (${filtersDataValues.selectedFilterCount})',
                  applyFilters,
                  widget.applyBtnState,
                  '0','',''),
            ),
          )
        ],
      ),
    );
  }
}
