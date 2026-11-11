import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_project/data/user_profile.dart';
import 'package:mobile_project/pages/home_page.dart';
import 'package:mobile_project/pages/progres_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('home greeting updates when the profile name changes', (
    tester,
  ) async {
    final profile = UserProfile.instance;
    await profile.updateName('Alifia Putri');
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await profile.updateName('Wynn Putri');
    await tester.pump();

    expect(find.text('Halo, Wynn 👋'), findsOneWidget);
    expect(
      (await SharedPreferences.getInstance()).getString('profile_name'),
      'Wynn Putri',
    );
  });

  testWidgets('progress profile updates its name and avatar', (tester) async {
    final profile = UserProfile.instance;
    await profile.updateName('Alifia Putri');
    await profile.updateAvatar(0);
    await tester.pumpWidget(const MaterialApp(home: ProgresPage()));

    await profile.updateName('Wynn Putri');
    await profile.updateAvatar(6);
    await tester.pump();

    expect(find.text('Wynn Putri'), findsOneWidget);
    expect(find.byIcon(Icons.rocket_launch), findsNWidgets(2));
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('profile_name'), 'Wynn Putri');
    expect(prefs.getInt('profile_avatar_index'), 6);
  });
}
