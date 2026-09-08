import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorSalariuApp());
}

class CalculatorSalariuApp extends StatelessWidget {
  const CalculatorSalariuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Salariu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CalculatorSalariuPage(),
    );
  }
}

class CalculatorSalariuPage extends StatefulWidget {
  const CalculatorSalariuPage({super.key});

  @override
  State<CalculatorSalariuPage> createState() => _CalculatorSalariuPageState();
}

class _CalculatorSalariuPageState extends State<CalculatorSalariuPage> {
  // Controller pentru preluarea textului din TextField
  final TextEditingController _salariuBrutController = TextEditingController();

  // Variabilă pentru opțiunea selectată (Tipul de angajat / impozitare)
  String _tipAngajat = 'standard';

  // Variabile pentru rezultate
  double? _salariuBrut;
  double? _salariuNet;
  double? _totalImpozite;
  String? _mesajEroare;

  // Metodă pentru calculul salariului
  void _calculeazaSalariu() {
    setState(() {
      _mesajEroare = null;

      final textIntrodus = _salariuBrutController.text.trim();
      final brut = double.tryParse(textIntrodus);

      if (brut == null || brut <= 0) {
        _mesajEroare = 'Vă rugăm să introduceți o valoare numerică validă.';
        _salariuNet = null;
        _totalImpozite = null;
        return;
      }

      _salariuBrut = brut;

      // - Standard: 25% contribuții sociale + 10% impozit pe venit (din rest)
      // - IT / Scutit: 25% contribuții sociale, 0% impozit pe venit
      // - Redus / Student: 10% contribuții, 5% impozit
      double rataContributii = 0.0;
      double rataImpozit = 0.0;

      switch (_tipAngajat) {
        case 'it':
          rataContributii = 0.25;
          rataImpozit = 0.0;
          break;
        case 'student':
          rataContributii = 0.10;
          rataImpozit = 0.05;
          break;
        case 'standard':
        default:
          rataContributii = 0.25;
          rataImpozit = 0.10;
          break;
      }

      final double contributii = brut * rataContributii;
      final double bazaImpozabila = brut - contributii;
      final double impozitVenit = bazaImpozabila * rataImpozit;

      _totalImpozite = contributii + impozitVenit;
      _salariuNet = brut - _totalImpozite!;
    });
  }

  @override
  void dispose() {
    _salariuBrutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Salariu Net'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. INPUT: Salariul Brut (TextField)
            TextField(
              controller: _salariuBrutController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Salariul Brut (MDL / RON)',
                hintText: 'ex: 15000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 20),

            // 2. DropdownButton pentru selectarea categoriei
            DropdownButtonFormField<String>(
              initialValue: _tipAngajat,
              decoration: const InputDecoration(
                labelText: 'Tip Angajat / Regim Impozitare',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'standard',
                  child: Text('Angajat Standard (Regim complet)'),
                ),
                DropdownMenuItem(
                  value: 'it',
                  child: Text('Sector IT (Scutit de impozit pe venit)'),
                ),
                DropdownMenuItem(
                  value: 'student',
                  child: Text('Student / Cotă redusă'),
                ),
              ],
              onChanged: (nouaValoare) {
                setState(() {
                  _tipAngajat = nouaValoare!;
                });
              },
            ),
            const SizedBox(height: 24),

            // 3. UI CONTROL: ElevatedButton cu eveniment onPressed
            ElevatedButton.icon(
              onPressed: _calculeazaSalariu,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'Calculează Salariul Net',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 24),

            // Afișare eroare dacă inputul este invalid
            if (_mesajEroare != null)
              Text(
                _mesajEroare!,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

            // 4. Afișarea rezultatelor
            if (_salariuNet != null && _totalImpozite != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rezultate Calcul:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 24),
                      Text(
                        'Salariu Brut: ${_salariuBrut!.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Taxe și Impozite: ${_totalImpozite!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Salariu Net de Primit: ${_salariuNet!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}