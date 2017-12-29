from os import listdir, getcwd
from os.path import isdir, isfile, join
import re

def lstRgx( 
    tpo = "d",      # Tipo de búsqueda f-> Archivos, d-> Directorios.
    pth = getcwd(), # String del Path donde se realiza la búsqueda.
    rgx = ""        # String con los comodines regex (Ej: ".*(IMG-).*").
    ):
    lst = [d for d in listdir(pth) if isdir(join(pth, d))]
    if tpo != "d"
        lst = [f for f in listdir(pth) if isfile(join(pth, f))]
    if rgx != "":
        rgx = re.compile( rgx )
        lst = [m.group(0) for l in lst for m in [rgx.search(l)] if m]
    return lst

# print lstRgx('.', ".*(IP).*")
# print lstRgx()

