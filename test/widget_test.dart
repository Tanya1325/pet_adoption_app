// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pet_adoption_app/main.dart';
import 'package:pet_adoption_app/screens/pets_list/pets_list_screen.dart';
import 'package:pet_adoption_app/utils/app_string_constants.dart';
import 'package:pet_adoption_app/widgets/pets_tile.dart';

void main() {
  testWidgets('test Check widget button contains text',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() => tester.pumpWidget(const MyApp()));
    await tester.pumpAndSettle();

    expect(find.text(AppStringConstants.letsGo.toUpperCase()), findsOneWidget);
    expect(find.text('ADOPT'), findsNothing);
  });

  testWidgets('test Check widget button contains text',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() async {
      await mockNetworkImagesFor(
          () async => await tester.pumpWidget(const MaterialApp(
                home: PetsListScreen(categoryIndex: 0),
              )));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
    });
    expect(find.byType(PetsTile), findsNothing);

    expect(find.text('Hello!!'), findsOneWidget);
  });
}
