#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# This script downloads de MOMA data to be used for the final poroject. 
# The repo with the data is: https://github.com/MuseumofModernArt/collection
# ---------------------------------------------------------------------------

# Download table Artists
curl https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv > ./data/Artists.csv

# Download table Artworks
curl https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv > ./data/Artworks.csv

# Print message for user
echo "\n\nData Artists.csv and Artworks.csv downloaded in \"pds-2019/data\" directory."