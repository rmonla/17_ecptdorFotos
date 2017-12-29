from os import listdir, getcwd
from os.path import isdir, isfile, join
import re

def lstRgx( 
    pth = getcwd(), # String del Path donde se realiza la búsqueda.
    rgx = ""        # String con los comodines regex (Ej: ".*(IMG-).*").
    ):
    lst = [a for a in listdir(pth) if isfile(join(pth, a))]
    if not rgx == "":
        rgx = re.compile( rgx )
        lst = [m.group(0) for l in lst for m in [rgx.search(l)] if m]
    return lst

# print lstRgx('.', ".*(IP).*")

