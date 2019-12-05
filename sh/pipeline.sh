#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# This script executes the necessary steps to extract, clean and process the
# moma database. 
# ---------------------------------------------------------------------------

# --- Download moma data ---
# Give execution permission 
chmod +x ./sh/download_moma_data.sh

# Download moma database
./sh/download_moma_data.sh


# --- Create the moma environment in python ---
# Give execution permission 
chmod +x ./sh/create_pyenv_moma.sh

# Create the moma environment in python for the pds-2019 directory
./sh/create_pyenv_moma.sh


# --- Create user and database in postgrers ---
# Give execution permission 
chmod +x ./sh/create_user_db_moma.sh

# Create user and database in postgres
./sh/create_user_db_moma.sh


# --- Process data ---

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

# Create features
python moma.py create-features
