#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# This script creates the user "moma" in postgres and the databse "moma".
# ---------------------------------------------------------------------------

# Change to user postgrers.
# Create the user "moma" with out permits to create databases.
# The password assigned to the moma user is: pds_moma
sudo -i -u postgres psql -c "CREATE USER moma WITH PASSWORD 'pds_moma' NOCREATEDB;"

# Print message for user. 
echo "\n\nUser \"moma\" created with password \"pds_moma\"."

# Create the database moma assigned to user moma. 
sudo -i -u postgres psql -c "CREATE DATABASE moma OWNER moma ENCODING 'UTF-8' LC_CTYPE 'en_US.UTF-8' LC_COLLATE 'en_US.UTF-8' TEMPLATE template0;"

# Print message for user 
echo "\n\nDatabase \"moma\" created and assigned to user \"moma\"."

