import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laborator2/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    for (final family in ['Outfit', 'OpenSans', 'Poppins']) {
      final loader = FontLoader(family)
        ..addFont(rootBundle.load('assets/fonts/$family.ttf'));
      await loader.load();
    }
  });
  testWidgets('Home opens appointment and books selected date and time', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MedicalApp());
    await tester.pumpAndSettle();
    expect(find.text('Hi, Jonathan'), findsOneWidget);
    expect(find.text('Health Services'), findsOneWidget);

    await tester.tap(find.text('Appointment'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('12.00 PM'));
    await tester.tap(find.text('12.00 PM'));
    await tester.ensureVisible(find.text('Mon 5'));
    await tester.tap(find.text('Mon 5'));
    await tester.tap(find.text('Book an Appointment'));
    await tester.pumpAndSettle();

    expect(find.text('Appointment Booked!'), findsOneWidget);
    expect(
      find.text('Your appointment with Dr. Upul is set for Mon 5 at 12.00 PM.'),
      findsOneWidget,
    );
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Hi, Jonathan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('A nearby doctor can be added to and removed from favorites', (
    tester,
  ) async {
    await tester.pumpWidget(const MedicalApp());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byTooltip('Favorite Dr. Emmly Lestiryno'));
    await tester.tap(find.byTooltip('Favorite Dr. Emmly Lestiryno'));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byTooltip('Favorite Dr. Emmly Lestiryno'), findsOneWidget);
    expect(find.byTooltip('Favorite Dr. Sonja Littel'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Search and health service filters show matching doctors', (
    tester,
  ) async {
    await tester.pumpWidget(const MedicalApp());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Sonja');
    await tester.pumpAndSettle();
    expect(find.text('Dr. Sonja Littel'), findsOneWidget);
    expect(find.text('Dr. Emmly Lestiryno'), findsNothing);
    await tester.enterText(find.byType(TextField), 'no such doctor');
    await tester.pumpAndSettle();
    expect(find.text('No doctors match your search.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.text('Tooth'));
    await tester.pumpAndSettle();
    expect(find.text('Dr. Sonja Littel'), findsOneWidget);
    expect(find.text('Dr. Emmly Lestiryno'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final size in [
    const Size(320, 640),
    const Size(375, 812),
    const Size(430, 932),
  ]) {
    testWidgets('Both screens fit ${size.width.toInt()}px width', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MedicalApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Appointment'));
      await tester.pumpAndSettle();
      expect(find.text('Book an Appointment'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
