#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
/*<®> Encarpetador de Fotos <®>*/
  /*<®> Descripción <®>*/
    Script que desde una carpeta lee los archivos de imágenes y
    las mueve a otro destino ordenado según fecha.
  
  /*<®> Items relizados y pendientes <®>*/
    [x] Genera una URL desde un ID de video de YouTube.
    [x] Descargar el html en un archivo temporal desde una URL.
    [ ] Genera una lista de URLS de los videos mas vistos.
    [ ] Descargar solo el audio de un video YouTube.
    [ ] Reproduce los audios de la lista.


  /*<®> Copyright (c) 2017 Ricardo MONLA (rmonla@gmail.com) <®>*/
"""

__proy__ = "ecptdorFotos.py"
__ver__  = "2.0.4"

como_se_usa = """\

uso: python """ + __proy__ + """ [opciones] -i IDYTB


requerido:
  -i --idytb             Id de video de youtube iniciador de la lista.

opciones:
  -h --help              Muestra ésta descripción.
  --version              Muestra versión del proyecto.

ejemplo:
  python """ + __proy__ + """ -i zpSBU0eUmmw
"""

version =  __proy__ + " version --> " + __ver__





from os import listdir, getcwd
from os.path import isdir, isfile, join
import re

def lstRgx(
    tpo = "d", 
    pth = getcwd(), 
    rgx = ""
    ):
    # Tipo de búsqueda f-> Archivos, d-> Directorios.
    # String del Path donde se realiza la búsqueda.
    # # String con los comodines regex (Ej: ".*(IMG-).*").
    
    lst = [d for d in listdir(pth) if isdir(join(pth, d))]
    if tpo != "d":
        lst = [f for f in listdir(pth) if isfile(join(pth, f))]
    if rgx != "":
        rgx = re.compile(rgx)
        lst = [m.group(0) for l in lst for m in [rgx.search(l)] if m]
    return lst

# print lstRgx('f', .', ".*(IP).*")
# print lstRgx()
