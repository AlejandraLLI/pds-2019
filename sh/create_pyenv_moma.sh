#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# Este script crea el ambiente virtual "moma" necesario para el proyecto
# ---------------------------------------------------------------------------

# Crea ambiente vitual moma
pyenv virtualenv 3.7.3 moma

# Ligarlo a la carpeta del proyecto
echo "moma" > .python-version

# Instalar poetry
pip install poetry 

# Instalar las dependencias que vienen en el archivo pyproject.toml
poetry install

# Imprimir mensaje 
echo "Se creó el ambiente virtual moma y se instalaron las librerías de python necesarias."
