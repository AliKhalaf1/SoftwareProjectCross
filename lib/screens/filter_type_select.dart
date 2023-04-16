// ignore_for_file: use_build_context_synchronously

library FilterTypeScreen;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/filters/filter_selection_values.dart';
import '../providers/filters/tag.dart';
import '../providers/filters/tags.dart';
import 'filters.dart';

/// {@category Screens}
///## FilterType screen that has date_tags list / categorey_tags list
///
///   • tagsData: Provider state for tags
///
///   • dateDataValues: tags related to date
///
///   • catDataValues: tags related to categorey
///
///   • filtersDataValues: Selected filters values

class FilterType extends StatelessWidget {
  final String title;
  final int id;

  // Constructor
  const FilterType(this.id, this.title, {super.key});

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  Future<DateTimeRange?> showDatePicker(BuildContext ctx) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: ctx,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 215, 67, 21)),
            primaryColor: Colors.deepOrange[800],
            badgeTheme: const BadgeThemeData(textColor: Colors.black),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 215, 67, 21),
                    surface: Color.fromARGB(255, 215, 67, 21))
                .copyWith(secondary: Colors.deepOrange[800]),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked.start != null && picked.end != null) {
      return picked;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //---------------- Variables ---------------//
    final tagsData = Provider.of<Tags>(context);
    final dateDataValues = tagsData.datetags;
    final catDataValues = tagsData.fieldtags;
    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

    //------------------ Methods -----------------//

    /// Determine selection and navigate back to filters screen.
    ///
    /// When a tag is selected this function apply it to filters throghout the program.
    ///
    ///   • select a tag from provider state tags
    ///
    ///   • update value of Selected filters values with selected new value
    ///
    void selectFilteration(BuildContext ctx, Tag toggleTag, int ind) async {
      toggleTag.selected = true;
      // Pick a date handler
      if (id == 0 && ind == 6) {
        final DateTimeRange? picked = await showDatePicker(ctx);
        DateFormat dateFormat = DateFormat('EEEE, MMMM d');
        DateFormat dayOnlydateFormat = DateFormat('dd');

        String dateRange = picked!.start.month == picked.end.month
            ? '${dateFormat.format(picked.start)} - ${dayOnlydateFormat.format(picked.end)}'
            : '${dateFormat.format(picked.start)} - ${dateFormat.format(picked.end)}';

        //Select tag value in filters screen
        toggleTag.value = dateRange;
        //select tag value for search screen (tags)
        filtersDataValues.date.selected = false;
        dynamic rem = filtersDataValues.date;
        for (var i = 0; i < tagsData.datetags.length; i++) {
          if (tagsData.datetags[i].title == filtersDataValues.date.title) {
            rem = tagsData.datetags[i];
          }
        }
        filtersDataValues.setDate(toggleTag);
        tagsData.tagSelectFilter(toggleTag, rem);

        Navigator.pop(context, picked);
      } else {
        // Apply selected tag to applicaton state provider
        dynamic rem;
        if (toggleTag.categ == 'date') {
          rem = filtersDataValues.date;
          for (var i = 0; i < tagsData.datetags.length; i++) {
            if (tagsData.datetags[i].title == filtersDataValues.date.title) {
              rem = tagsData.datetags[i];
            }
          }
          filtersDataValues.setDate(toggleTag);
        } else {
          rem = filtersDataValues.cat;
          for (var i = 0; i < tagsData.fieldtags.length; i++) {
            if (tagsData.fieldtags[i].title == filtersDataValues.cat.title) {
              rem = tagsData.fieldtags[i];
            }
          }
          filtersDataValues.setCat(toggleTag);
        }
        tagsData.tagSelectFilter(toggleTag, rem);
        // Pop back to filters screen
        Navigator.pop(ctx);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(206, 255, 255, 255),
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 5,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 15,
                height: 0.9,
                letterSpacing: 1.3,
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(17, 3, 59, 1)),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.orange.shade900,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 40),
            itemCount: id == 0 ? dateDataValues.length : catDataValues.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => id == 0
                    ? selectFilteration(context, dateDataValues[index], index)
                    : selectFilteration(context, catDataValues[index], index),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, bottom: 20, top: 20),
                  child: id == 0
                      ? !dateDataValues[index].selected
                          ? Text(
                              dateDataValues[index].title,
                              style: const TextStyle(
                                  fontSize: 22,
                                  height: 0.9,
                                  letterSpacing: 1.3,
                                  fontFamily: 'Neue Plak Extended',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(17, 3, 59, 1)),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateDataValues[index].title,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      height: 0.9,
                                      letterSpacing: 1.3,
                                      fontFamily: 'Neue Plak Extended',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 35, 80, 205)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Icon(
                                    Icons.check,
                                    color: Color.fromARGB(255, 35, 80, 205),
                                    size: 20,
                                  ),
                                ),
                              ],
                            )
                      : !catDataValues[index].selected
                          ? Text(
                              catDataValues[index].title,
                              style: const TextStyle(
                                  fontSize: 22,
                                  height: 0.9,
                                  letterSpacing: 1.3,
                                  fontFamily: 'Neue Plak Extended',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(17, 3, 59, 1)),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  catDataValues[index].title,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      height: 0.9,
                                      letterSpacing: 1.3,
                                      fontFamily: 'Neue Plak Extended',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 35, 80, 205)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Icon(
                                    Icons.check,
                                    color: Color.fromARGB(255, 35, 80, 205),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
