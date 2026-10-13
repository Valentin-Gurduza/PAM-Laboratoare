# Laborator 2 — Medical Healthcare App

Interfață Flutter bazată pe [Laboratoare 2026 — Figma](https://www.figma.com/design/doYnD2o1IUY7fwsxfqTIQf/Laboratoare-2026--Copy-?node-id=2-673).

Ecranele implementate: Homescreen (`2:1783`, 375 × 812) și Appointment details (`3:335`, 430 × 932). Layoutul permite derulare și se adaptează la lățimi de 320–430 pixeli. Pe telefon se păstrează bara de stare a sistemului; previzualizarea desktop/web include bara din design.

Imaginile și iconurile sunt exportate din Figma și păstrate local în `assets/images/` și `assets/icons/`. Iconurile SVG își păstrează dimensiunile originale. Fonturile Outfit, Open Sans și Poppins sunt incluse local, cu licențele OFL. Culorile și stilurile sunt centralizate în `lib/design.dart`.

Funcționalități: căutare după nume/specialitate/adresă, filtrare după serviciu și favorite, adăugare/eliminare favorite, deschiderea medicului selectat, selectarea datei/orei și confirmarea programării. Butoanele See All afișează serviciile/opțiunile suplimentare ori resetează filtrele. Comunicarea și programarea sunt demonstrative, fără un serviciu extern conectat.

```bash
flutter pub get
flutter run
flutter analyze
flutter test
flutter build apk --debug
```

Testele verifică navigarea, programarea cu data/ora selectată, favoritele, căutarea, filtrarea și afișarea ambelor ecrane la lățimi de 320, 375 și 430 pixeli.
