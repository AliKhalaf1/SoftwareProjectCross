library SearchScreen;

import 'package:Eventbrite/providers/filters/tags.dart';
import 'package:Eventbrite/providers/filters/temp_tags.dart';
import 'package:Eventbrite/widgets/grey_area.dart';
import 'package:flutter/material.dart';

import '../providers/filters/filter_selection_values.dart';
import '../providers/filters/tag.dart';
import '../providers/filters/temp_selected_filter_values.dart';
import '../widgets/event_collection.dart';
import 'filters.dart';
import 'package:provider/provider.dart';
import '../providers/events/events.dart';
import 'nearby_events.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the search results.
///
class Search extends StatefulWidget {
  static const searchPageRoute = '/search';

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ///Navigate to Nearby events page
  void goToBearby(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const NearbyEvents();
    }));
  }

  @override
  Widget build(BuildContext context) {
    //------------------------------------- Variables -------------------------------------------------//
    ///Event list
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.events;

    final tagsData = Provider.of<Tags>(context);
    final tags = tagsData.tagsToShow;

    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

    final tempTagsData = Provider.of<TemporaryTags>(context);
    final tempFiltersDataValues =
        Provider.of<TempFilterSelectionValues>(context);

    //------------------------------------- Methods -------------------------------------------------//
    /// Function that select tags and render thier new style.
    ///
    /// When a tag is selected this function apply it to filters throghout the program.
    void selectTag(BuildContext ctx, Tag toggleTag) {
      setState(() {
        if (toggleTag.selected) {
          tagsData.tagRemove(toggleTag);
          --filtersDataValues.selectedFilterCount;
          if (toggleTag.categ == 'date') {
            filtersDataValues
                .setDate(tagsData.datetags[0]); //set it by ---Anytime---
          } else {
            filtersDataValues
                .setCat(tagsData.fieldtags[0]); //set it by ---Anything---
          }
        } else {
          tagsData.tagSelect(toggleTag);
          ++filtersDataValues.selectedFilterCount;
          if (toggleTag.categ == 'date') {
            filtersDataValues.setDate(toggleTag);
          } else {
            filtersDataValues.setCat(toggleTag);
          }
        }
      });
    }

    ///View Filters handeler function.
    ///
    ///Naviagtes only to silters screen.
    void viewFilters(BuildContext ctx) {
      tempTagsData.setAll(tagsData);
      tempFiltersDataValues.setAll(filtersDataValues);
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return FilterScreen();
      }));
    }

    return Scaffold(
        key: const Key("SearchScreen"),
        appBar: AppBar(
          backgroundColor: Colors.white38,
          foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              key: const Key("GoToFiltersBtn"),
              icon: const Icon(
                Icons.filter_list_sharp,
                color: Colors.black,
              ),
              onPressed: () => viewFilters(context),
            ),
          ],
        ),
        body: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: const Color.fromARGB(255, 255, 72, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  key: const Key("GoToNearbyEvents"),
                  onTap: () => goToBearby(context),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: TextButton(
                          onPressed: null,
                          child: Text(
                            'Online events',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color.fromARGB(229, 41, 41, 41),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    key: Key("TextFieldInput"),
                    cursorWidth: 0.5,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Start searching...',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(229, 41, 41, 41), width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 67, 96, 244),
                            width: 2.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.right,
                      color: const Color.fromARGB(255, 255, 72, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tags.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ChangeNotifierProvider.value(
                            value: tags[index],
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: tags[index].selected
                                      ? const Color.fromARGB(255, 67, 96, 244)
                                      : const Color.fromARGB(
                                          255, 242, 242, 242)),
                              child: InkWell(
                                key: const Key("TagSelectionGesture"),
                                borderRadius: BorderRadius.circular(60),
                                splashColor:
                                    const Color.fromARGB(255, 67, 96, 244),
                                onTap: () => selectTag(
                                    context,
                                    tags[
                                        index]), // Action when button is pressed
                                child: Container(
                                  height: 10,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        tags[index].value,
                                        style: TextStyle(
                                            color: tags[index].selected
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 104, 104, 104),
                                            fontSize: 12),
                                      ),
                                      tags[index].selected
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Icon(
                                                Icons.close_outlined,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            )
                                          : const GreyArea()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.orange.shade900,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 40),
                      itemCount: 1, // substitute with collectionCounts
                      itemBuilder: (ctx, index) {
                        return EventCollections(
                            "${events.length} events", false, events);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
