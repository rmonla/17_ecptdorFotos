#!/usr/bin/env python
# -*- coding: utf-8 -*-

__proy__ = "ecptdorFotos.py"
__ver__  = "2.0.6"

"""
/*<®> Encarpetador de Fotos <®>*/
  /*<®> Descripción <®>*/
    Script que desde una carpeta lee los archivos de imágenes y
    las mueve a otro destino ordenado según fecha.
  
  /*<®> Items relizados y pendientes <®>*/
    [x] fx 'lstRgx' Retorna una lista de directorios o archivos 
        de un path dado y pudiendo utilizar comodines Regex.
    [ ] fx que genere el adminstrador de parámetros.
    [ ] fx que genere una string para mostrar un msj como_se_usa.


  /*<®> Copyright (c) 2017 Ricardo MONLA (rmonla@gmail.com) <®>*/
"""





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
    tpo = "d",      # Tipo de búsqueda f-> Archivos, d-> Directorios.
    pth = getcwd(), # 
    
    rgx = ""        # String con los comodines regex (Ej: ".*(IMG-).*").
    ):
    
    lst = [d for d in listdir(pth) if isdir(join(pth, d))]
    if tpo != "d":
        lst = [f for f in listdir(pth) if isfile(join(pth, f))]
    if rgx != "":
        rgx = re.compile(rgx)
        lst = [m.group(0) for l in lst for m in [rgx.search(l)] if m]
    return lst

# print lstRgx('f', .', ".*(IP).*")
# print lstRgx()

# /*<®> Parametrisación <®>*/
def rmParams():
  aPrmtros = [
    ("-h", "help",     "help"   ),
    ("-v", "version",  "version"),
    ("-t", "tipobusc", "tpo"    ),
    ("-p", "path",     "pth"    ),
    ("-r", "regex",    "rgx"    )
  ]
  



if __name__ == "__main__":
  if '-h' in sys.argv or '--help' in sys.argv: 
    msj(como_se_usa, 1)
      
  if "--version" in sys.argv: 
    msj(version, 1)

  from optparse import OptionParser
  prmtros = OptionParser()
  prmtros.add_option("-i", "--idytb", dest="idytb")
  prmtros.add_option("-o", "--output", dest="output")
  prmtros.add_option("-u", "--url",    dest="url")
  prmtros.add_option("-t", "--ytb_tit", dest="ytb_tit")
  prmtros.add_option(      "--fnom",   dest="fnom") #Solo uso interno.
  (opts, args) = prmtros.parse_args()
  # parser.add_option("-f", "--fnom",  dest="fnom") #Solo uso interno.

#*<®> AutoRun <®>*
if not opts.idytb:
  msj('No se puede iniciar sin un ID')
  msj(como_se_usa, 1)
else:
  radioTube()


msj('FIN DEL PROGRAMA', 1)
