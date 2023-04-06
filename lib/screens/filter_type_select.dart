library FilterTypeScreen;

import 'package:flutter/material.dart';

import 'filters.dart';

class FilterType extends StatelessWidget {
  final String title;
  final List<String> selections;
  const FilterType(this.title, this.selections, {super.key});

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  void showDatePicker(BuildContext ctx) {
    showDateRangePicker(
      context: ctx,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context,child) {
    return Theme(
      data: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 215, 67, 21)),
        primaryColor: Colors.deepOrange[800],
        badgeTheme: const BadgeThemeData(textColor: Colors.black),
        buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 215, 67, 21), surface: Color.fromARGB(255, 215, 67, 21)).copyWith(secondary: Colors.deepOrange[800]),
      ),
      child: child!,
    );
  },

    );
  }

  /* Method to determine selection and navigate back to filters screen*/
  void selectFilteration(BuildContext ctx, int ind) {
    // Pick a date handler
    if (selections.length == 7 && ind == 6) {
      showDatePicker(ctx);
    } else {
      // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //   return FilterScreen([]);
      // }));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: selections.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => selectFilteration(context, index),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, bottom: 20, top: 20),
                  child:
                      // Text(
                      //       selections[index],
                      //       style: const TextStyle(
                      //           fontSize: 22,
                      //           height: 0.9,
                      //           letterSpacing: 1.3,
                      //           fontFamily: 'Neue Plak Extended',
                      //           fontWeight: FontWeight.w600,
                      //           color: Color.fromRGBO(17, 3, 59, 1)),
                      //     ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selections[index],
                        style: const TextStyle(
                            fontSize: 22,
                            height: 0.9,
                            letterSpacing: 1.3,
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(17, 3, 59, 1)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Icon(
                          Icons.check,
                          color: Color.fromARGB(255, 41, 74, 240),
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
