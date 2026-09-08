import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laborator1/main.dart';

void main() {
  testWidgets('Test de bază - Calculator Salariu UI', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorSalariuApp());

    expect(find.text('Calculator Salariu Net'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Test calcul salariu net standard', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorSalariuApp());

    final textField = find.byType(TextField);
    await tester.enterText(textField, '10000');
    await tester.pump();

    final calculateBtn = find.text('Calculează Salariul Net');
    await tester.tap(calculateBtn);
    await tester.pumpAndSettle();

    // Brut: 10000
    // Contribuții (25%): 2500
    // Baza impozabilă: 7500
    // Impozit (10%): 750
    // Total taxe: 3250
    // Net: 6750
    expect(find.text('Salariu Brut: 10000.00'), findsOneWidget);
    expect(find.text('Total Taxe și Impozite: 3250.00'), findsOneWidget);
    expect(find.text('Salariu Net de Primit: 6750.00'), findsOneWidget);
  });
}
