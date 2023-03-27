import '../../../lib/screens/user/profile.dart';
import '../../../lib/widgets/button_find_things.dart';
import '../../../lib/widgets/button_link.dart';
import '../../../lib/widgets/button_notificatin.dart';
import '../../../lib/widgets/counterbutton.dart';
import '../../../lib/widgets/grey_area.dart';
import '../../../lib/widgets/profile_layer.dart';
import '../../../lib/widgets/round_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Profile', () {
    testWidgets('renders all UI elements', (WidgetTester tester) async {
      const firstName = 'Ahmed';
      const lastName = 'Ehab';
      const email = 'AhmedEhab@yahoo.com';
      const imageUrl = 'assets/images/no_user_found.jfif';
      const likesCount = 5;
      const myTicketsCount = 2;
      const followingCount = 10;

      await tester.pumpWidget(
        MaterialApp(
          home: Profile(firstName, lastName, imageUrl, email, likesCount,
              myTicketsCount, followingCount, () {}),
        ),
      );

      // Check that all UI elements are present
      expect(find.text('$firstName $lastName'), findsOneWidget);
      expect(find.text(email), findsOneWidget);
      expect(find.byType(ProfileImage), findsOneWidget);
      expect(find.byType(GreyArea), findsOneWidget);
      expect(find.byType(ProfileLayer), findsOneWidget);
      expect(find.byType(CounterButton), findsNWidgets(3));
      expect(find.byType(ButtonLink), findsNWidgets(5));
      expect(find.byType(ButtonNotification), findsNWidgets(1));
      expect(find.byType(GreyButtonLogout), findsOneWidget);
    });
  });
}
