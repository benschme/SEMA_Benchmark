#!/bin/bash

# All outputs are additionally stored in the Benchmark_Log_SEMA.txt file

###################################
# Section 1: Initialize Database
###################################

# Create SQLite Database and customize settings
echo -e ".databases\nPRAGMA journal_mode=DELETE;\nPRAGMA synchronous=FULL;\n.exit" >> sqlitecommands.txt
sqlite3 SEMA_DB.sqlite3 < sqlitecommands.txt
rm sqlitecommands.txt

# Create Table
sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_Initialize.sql

# Pre-population of the database
echo -e "# PRE-POPULATION SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1

# Read extent count
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

###################################
# Section 2: Benchmark Runs
###################################

# INSERT Run

echo -e "# INSERTS SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_INSERTS.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

# SELECT Run

echo -e "# SELECTS SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_SELECTS.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

# DELETE Run

echo -e "# DELETES SECTION\n\n" >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt
(time sqlite3 SEMA_DB.sqlite3 < /home/sema/Benchmark/SQLite_Benchmark_DB_DELETES.sql) >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt 2>&1
filefrag SEMA_DB.sqlite3 >> /home/sema/Benchmark/Benchmark_Log_SEMA.txt

# CleanUp: Remove database
rm -f SEMA_DB.sqlite3

