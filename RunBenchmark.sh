#!/bin/bash

# Alle Ausgaben werden zusätzlich in die Datei Benchmark_Log_SEMA.txt gespeichert

#######################
# Initialize Database
#######################

# SQLite Datenbank erstellen und Einstellungen anpassen - Journal- und Synchronous Mode
echo -e ".databases\nPRAGMA journal_mode=DELETE;\nPRAGMA synchronous=FULL;\n.exit" >> sqlitecommands.txt
sqlite3 SEMA_DB.sqlite3 < sqlitecommands.txt
rm sqlitecommands.txt

# Tabelle erstellen
sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_Initialize.sql

# Pre-population der Datenbank
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1

# Extents auslesen
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

#######################
# INSERTS Run
#######################

echo -e "# INSERTS SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_INSERTS.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

#######################
# SELECTS Run
#######################

echo -e "# SELECTS SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_SELECTS.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

#######################
# DELETES Run
#######################

echo -e "# DELETES SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_DELETES.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

# Datenbank entfernen
rm -f SEMA_DB.sqlite3

