#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# This script executes the necessary python modules to process the
# moma database. 
# ---------------------------------------------------------------------------

# Get into moma directory 
cd moma

# Create raw, cleaned, semantic and features schemas from moma.py file
python moma.py create-schemas

# Create tables for raw schema
python moma.py create-raw-tables

# Load raw data to raw schema
python moma.py load-moma

# Pass raw data to clean schema
python moma.py to-cleaned

# Pass cleaned data to semantic schema
python moma.py to-semantic

# Create tables for the cohort schema 
python moma.py create-cohorts

# Create tables for the labels schema
python moma.py create-labels

# Create tables for the features schema
python moma.py create-features