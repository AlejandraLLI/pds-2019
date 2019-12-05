#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# Este script crea el usuario "moma" en postgres y la base de datos "moma".
# ---------------------------------------------------------------------------

# Cambiamos al usuario postgres. 
# Creamos el usuario moma sin permiso para crear bd. 
# El password asignado al usuario es: pds_moma
sudo -i -u postgres psql -c "CREATE USER moma WITH PASSWORD 'pds_moma' NOCREATEDB;"

# Imprimir mensaje 
echo "Se creó el usuario \"moma\" con password \"pds_moma\"."

# Ceamos la base de datos moma asignada al usuario moma. 
sudo -i -u postgres psql -c "CREATE DATABASE moma OWNER moma ENCODING 'UTF-8' LC_CTYPE 'en_US.UTF-8' LC_COLLATE 'en_US.UTF-8' TEMPLATE template0;"

# Imprimir mensaje 
echo "Se creó la base de datos \"moma\" asignada al usuaio \"moma\"."

