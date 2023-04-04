library FiltersScreen;

import 'package:flutter/material.dart';
import '../models/tags.dart';
import '../widgets/title_text_1.dart';
import '../widgets/transparent_button_no_icon.dart';
import 'tab_bar.dart';

class FilterScreen extends StatefulWidget {
  List<Tag> selectedTags; /* Selected Tags */
  FilterScreen(this.selectedTags, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //---------------- Variables ---------------//
  final List<Tag> tags = [
    Tag('Today', false),
    Tag('Tomorrow', false),
    Tag('This weekend', false),
    Tag('This month', false),
    Tag('past', false),
    Tag('Learn', false),
    Tag('Business', false),
    Tag('Health & Weellness', false),
    Tag('Tech', false),
  ];

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
                padding: const EdgeInsets.only(top: 40),
                itemCount: 1, // substitute with collectionCounts
                itemBuilder: (ctx, index) {
                  return Column();
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
                  applyFilters),
            ),
          )
        ],
      ),
    );
  }
}
