# Seminararbeit im Studiengang Informatik FS21
## Leistungsvergleich von Dateisystemen mittels SQLite

Dieser Benchmark dient zum Vergleich der Leistung auf einem beliebigen Dateisystem unter einem reproduzierbares SQLite Workload.

Das Benchmark Skript ist in zwei Teile gegliedert. Zuerst wird die Datenbank initialisiert, dazu gehört das Erstellen der Datenbank, die Konfiguration der verschiedenen Parameter sowie die Vorbelegung der Datensätze. Im nächsten Abschnitt folgen die drei Leistungsmessungen, die mit drei SQL Statements umgesetzt werden.

Die wichtigsten Parameter, die gemessen werden, sind:

- Vorbelegung einer Datenbank mit 100'000 Datensätze
- Anfügen von Datensätze (1'000 Operationen)
- Lesen von zufälligen Datensätze (1'000 Operationen)
- Löschen von zufälligen Datensätze (1'000 Operationen)

Ausgabe ist die Zeitmessung je Run die für 1'000 Operationen aufgewendet wird.


Beiträge und Feedback sind willkommen!
