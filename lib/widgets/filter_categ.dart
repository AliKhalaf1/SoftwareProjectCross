library FilterCategWidget;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filters/filter_selection_values.dart';
import '../screens/filter_type_select.dart';
import '../screens/nearby_events.dart';

class FilterCateg extends StatefulWidget {
  final int id;
  final String title;
  const FilterCateg(this.id, this.title, {super.key});

  @override
  State<FilterCateg> createState() => _FilterCategState();
}

class _FilterCategState extends State<FilterCateg> {
  /* Method to call categorey screen */
  //Select the filter type
  void applyFilters(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      if (widget.id == 0 || widget.id == 2) {
        if (widget.id == 0) {
          return const FilterType(0, 'When do you want to go?');
        } else {
          return const FilterType(1, 'What categories are you interested in?');
        }
      } else {
        return const NearbyEvents();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    //---------------- Variables ---------------//

    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () => applyFilters(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 122, 121, 121),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              widget.id == 0
                  ? filtersDataValues.date.title
                  : (widget.id == 1 ? 'Online' : filtersDataValues.cat.title),
              style: const TextStyle(
                  fontSize: 22,
                  height: 0.9,
                  letterSpacing: 1.3,
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(17, 3, 59, 1)),
            ),
          ],
        ),
      ),
    );
  }
}
