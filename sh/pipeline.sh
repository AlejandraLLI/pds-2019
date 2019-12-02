#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# Este script clona el repositorio de github del proyecto y ejecuta los 
# scripts necesarios para extraer, limpiar y procesar la base de datos moma. 
# ---------------------------------------------------------------------------

# Ir a la raiz
cd ~

# --- Clonar el repositorio del proyecto ---
git clone https://github.com/AlejandraLLI/pds-2019.git

# Entrar a la carpeta del proyecto y crear subcarpetas
cd pds-2019
 

# --- Descargar los datos moma ---
# Dar permisos de ejecución
chmod +x ./sh/descarga_datos_moma.sh

# Descargar la base de datos 
./sh/descarga_datos_moma.sh


# --- Crear ambiente moma en python ---
# Dar permisos de ejecución
chmod +x ./sh/crear_pyenv_moma.sh

# Crear el ambiente "moma" de python para la carpeta 
./sh/crear_pyenv_moma.sh


# --- Crear usuario y base de datos postgres---
# Dar permisos de ejecución
chmod +x ./sh/crear_usuario_bd_moma.sh

# Crear usuario y base de datos en postgres 
./sh/crear_usuario_bd_moma.sh


# --- Procesar los datos ---

# Entrar a la carpeta moma 
cd moma

# Creamos los esquemas raw, cleaned, semantic y 
# features desde el archivo moma.py
python moma.py create-schemas

# Creamos las tablas del esquema raw
python moma.py create-raw-tables

# Cargamos los datos crudos al esquema raw
python moma.py load-moma

# Pasamos los datos al esquema clean
python moma.py to-cleaned