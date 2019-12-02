#!/bin/sh

# Programación para Ciencia de Datos
# Poyecto Final
# Alejandra Lelo de Larrea Ibarra			124433
# Itzel Zayil Muñoz Fernández de Córdova	122803
# René Rosado González						137085
# ---------------------------------------------------------------------------
# Este script descarga los datos de MOMA a utilizar para el proyecto final. 
# El repositorio con los datos es: https://github.com/MuseumofModernArt/collection
# ---------------------------------------------------------------------------

# Descargar la tabla Artists
curl https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv > ./data/Artists.csv

# Descargar la tabla Artworks
curl https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv > ./data/Artworks.csv

# Imprimir mensaje 
echo "Datos Artists.csv y Artworks.csv descagados en \"pds-2019/data\"."