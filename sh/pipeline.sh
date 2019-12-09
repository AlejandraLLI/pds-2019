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


# --- Create user and database in postgrers ---
# Give execution permission 
chmod +x ./sh/create_user_db_moma.sh

# Create user and database in postgres
./sh/create_user_db_moma.sh


# --- Process data ---
# Give execution permission 
chmod +x ./sh/process_data.sh

# Create user and database in postgres
./sh/process_data.sh