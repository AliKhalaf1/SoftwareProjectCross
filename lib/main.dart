import 'package:Eventbrite/providers/categories/categories.dart';
import 'package:Eventbrite/providers/events/fav_events.dart';
import 'package:Eventbrite/providers/filters/tags.dart';
import 'package:Eventbrite/providers/filters/temp_tags.dart';
import 'package:Eventbrite/screens/creator/description_title.dart';
import 'package:Eventbrite/screens/creator/event_location.dart';
import 'package:Eventbrite/screens/creator/event_start_end_date.dart';
import 'package:Eventbrite/screens/creator/event_title.dart';
import 'package:Eventbrite/screens/event_page.dart';
import 'package:Eventbrite/screens/guest/home.dart';
import 'package:Eventbrite/screens/search_screen.dart';
import 'package:Eventbrite/screens/user/account_settings.dart';
import 'package:Eventbrite/screens/creator/past_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/filters/filter_selection_values.dart';
import 'providers/filters/temp_selected_filter_values.dart';
import 'providers/tickets/tickets.dart';
import 'screens/sign_up/sign_up_or_log_in.dart';
import 'screens/tab_bar.dart';
import 'screens/sign_in/email_check.dart';
import './screens/find_tickets.dart';
import 'widgets/tab_bar_Events.dart';
import 'providers/events/events.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Events(),
        ),
        ChangeNotifierProvider.value(
          value: FavEvents(),
        ),
        ChangeNotifierProvider.value(
          value: Tags(),
        ),
        ChangeNotifierProvider.value(
          value: TemporaryTags(),
        ),
        ChangeNotifierProvider.value(
          value: FilterSelectionValues(),
        ),
        ChangeNotifierProvider.value(
          value: TempFilterSelectionValues(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: Tickets(),
        ),
      ],
      child: MaterialApp(
        title: 'Eventbrite',

        theme: ThemeData(
          // This is the theme of your application.

          fontFamily: 'Neue Plack Extended',
          primaryColor: const Color.fromARGB(255, 209, 65, 12),
          cardColor: const Color.fromRGBO(91, 89, 107, 1),
        ),

        // home: const TabBarScreen(title: 'Eventbrite'),
        initialRoute: TabBarScreen.tabBarScreenRoute,
        routes: {
          TabBarScreen.tabBarScreenRoute: (ctx) =>
              TabBarScreen(title: 'Eventbrite', tabBarIndex: 0),
          SignUpOrLogIn.signUpRoute: (ctx) => const SignUpOrLogIn(),
          EmailCheck.emailCheckRoute: (ctx) => EmailCheck(),
          FindTickets.findTicketsRoute: (ctx) => const FindTickets(),
          TabBarEvents.route: (ctx) => TabBarEvents(),
          PastEvents.route: (ctx) => PastEvents(),
          EventTitle.route: (ctx) => EventTitle(),
          Event_Description.route: (ctx) => Event_Description(),
          AccountSettings.accountSettingsRoute: (ctx) => AccountSettings(),
          EventDate.route: (ctx) => EventDate(),
          EventPage.eventPageRoute: (ctx) => const EventPage(),
          EventLocation.route: (ctx) => EventLocation(),
          Home.homePageRoute: (ctx) => Home(),
          Search.searchPageRoute: (ctx) => const Search(),
        },
      ),
    );
  }
}
