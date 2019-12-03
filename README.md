# Final Project: Programming for Data Science 2019

This project provides a structured workflow for loading and analyzing the The Museum of Modern Art ([MoMA]) research dataset  [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3524700.svg)](https://doi.org/10.5281/zenodo.3524700) using [PosgtreSQL] and [Python 3.7.3] as part of the final project of Programming for Data Science 2019. 

#### Contact Information

  - Alejandra Lelo de Larrea Ibarra  - - 124433
  - Itzel Zayil Muñoz Fernández de Córdova - - 122803
  - René Rosado González - - 137085

#### Data Source

This project utilizes The Museum of Modern Art ([MoMA]) research dataset 
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3524700.svg)](https://doi.org/10.5281/zenodo.3524700)
> This research dataset contains 138,124 records, representing all of the works that 
> have been accessioned into MoMA’s collection and cataloged in our database.  ([MoMa])

The database is compossed of two tables 
> It includes basic metadata for each work, including title, artist, date made, medium,
> dimensions, and date acquired by the Museum. Some of these records have incomplete 
> information and are noted as “not Curator Approved.”  ([MoMa])


   [PosgtreSQL]: <https://www.postgresql.org/>
   [Python 3.7.3]: <https://www.python.org/downloads/release/python-373/>
   [MoMa]: <https://github.com/MuseumofModernArt/collection>

#### Workflow

The sh directory in the repo, contains **.sh** files that execute the complete workflow:

  - Creating the virtual environment and installing python packages -- *crear_pyenv_moma.sh*
  - Downloading MoMA files -- *descargar_datos_moma.sh*
  - Creating the database -- *crear_usuario_bd_moma.sh*
  - Cleaning the database -- *pipeline.sh*
  - Creating the semantic schema -- *pipeline.sh*
  - Creating features -- *pipeline.sh*
 
#### Semantic Schema
  - Entity -- artist
  - Events -- artist's artwork is accessioned into MoMA’s collection 