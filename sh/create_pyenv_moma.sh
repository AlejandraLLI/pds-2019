#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# This script creates the vitual environment "moma" needed for the project
# ---------------------------------------------------------------------------

# Create moma virtual environment
pyenv virtualenv 3.7.3 moma

# Link the moma environt to the pds-2019 directory
echo "moma" > .python-version

# Install poetry
pip install poetry 

# Install all dependencies in the pyproject.toml file
poetry install

# Print message for user
echo "\n\nThe moma virtual envionment was created. All needed libraries were installed."
