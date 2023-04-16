library FilterTypeScreen;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filters/filter_selection_values.dart';
import '../providers/filters/tag.dart';
import '../providers/filters/tags.dart';
import 'filters.dart';

class FilterType extends StatelessWidget {
  final String title;
  final int id;
  // final List<String> selections;
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

  /* Method to determine selection and navigate back to filters screen*/
  void selectFilteration(BuildContext ctx, int ind) async {
    // Pick a date handler
    if (id == 0 && ind == 6) {
      final DateTimeRange? picked = await showDatePicker(ctx);
    } else {
      // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //   return FilterScreen([]);
      // }));
    }
  }

  @override
  Widget build(BuildContext context) {
    //---------------- Variables ---------------//
    final filtersDataValues = Provider.of<FilterSelectionValues>(context);
    final tagsData = Provider.of<Tags>(context,listen: false);

    final dateDataValues = tagsData.datetags;
    final catDataValues = tagsData.fieldtags;

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
                onTap: () => selectFilteration(context, index),
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
