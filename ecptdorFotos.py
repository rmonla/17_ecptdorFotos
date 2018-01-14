#!/usr/bin/env python
# -*- coding: utf-8 -*-

__aut__  = "<®>Copyright (c) 2017 Ricardo N. MONLA (rmonla@gmail.com)<®>"
__fmod__ = "2018-01-14"
__ver__  = "2.0.7"

"""
/*<®> Encarpetador de Fotos <®>*/
  /*<®> Descripción <®>*/
    Script que desde una carpeta lee los archivos de imágenes y
    las mueve a otro destino ordenado según fecha.
  
  /*<®> Items relizados y pendientes <®>*/
    [x] fx 'lstRgx' Retorna una lista de directorios o archivos 
        de un path dado y pudiendo utilizar comodines Regex.
    [x] rmArgs.py adminstrador de argumentos y parámetros.
    [x] rmFxs.py funciones comunes del proyecto.
    [ ] Verificar y hacer que auto arranque.
    [ ] fx que genere una string para mostrar un msj como_se_usa.

"""

from os import listdir, getcwd
from os.path import isdir, isfile, join
import re


def lstRgx(
    tpo = "d",      # Tipo de búsqueda f-> Archivos, d-> Directorios.
    pth = getcwd(), # 
    
    rgx = ""        # String con los comodines regex (Ej: ".*(IMG-).*").
    ):
    
    lst = [d for d in listdir(pth) if isdir(join(pth, d))]
    if tpo != "d": lst = [f for f in listdir(pth) if isfile(join(pth, f))]
    if rgx != "":
        rgx = re.compile(rgx)
        lst = [m.group(0) for l in lst for m in [rgx.search(l)] if m]
    return lst

# print lstRgx('f', .', ".*(IP).*")
# print lstRgx()

# /*<®> Parametrisación <®>*/
import rmArgs

# /*<®> Funciones <®>*/
import rmFxs



if __name__ == "__main__":
  if '-h' in sys.argv or '--help' in sys.argv: 
    msj(como_se_usa, 1)
      
  if "--version" in sys.argv: 
    msj(version, 1)


#*<®> AutoRun <®>*
if not opts.idytb:
  msj('No se puede iniciar sin un ID')
  msj(como_se_usa, 1)
else:
  radioTube()


msj('FIN DEL PROGRAMA', 1)
