from os import listdir, getcwd
from os.path import isfile, join
import re

def lstRe( pth = getcwd() ):
	lst = [arch for arch in listdir(pth) if isfile(join(pth, arch))]
	regex=re.compile(".*(IMG-).*")
	print [m.group(0) for l in lst for m in [regex.search(l)] if m]
	



from os import walk

def ls(ruta = '.'):
    dir, subdirs, archivos = next(walk(ruta))
    print("Actual: ", dir)
    print("Subdirectorios: ", subdirs)
    print("Archivos: ", archivos)
    return archivos

from os import walk, getcwd

def ls(ruta = getcwd()):
    listaarchivos = []
    for (_, _, archivos) in walk(ruta):
        listaarchivos.extend(archivos)
    return listaarchivos

list=['a cat','a dog','a yacht','cats']

[m.group(0) for l in list for m in [regex.search(l)] if m]
['a cat', 'cats']

[m.group(1) for l in list for m in [regex.search(l)] if m]
['cat', 'cat']


from os import scandir, getcwd
from os.path import abspath

def ls(ruta = getcwd()):
    return [abspath(arch.path) for arch in scandir(ruta) if arch.is_file()]

from os import listdir

def ls(ruta = '.'):
    return listdir(ruta)

from os import listdir
from os.path import isfile, join

def ls(ruta = '.'):
    return [arch for arch in listdir(ruta) if isfile(join(ruta, arch))]