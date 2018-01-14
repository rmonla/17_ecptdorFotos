#!/usr/bin/env python
# -*- coding: utf-8 -*-

__aut__  = "<®>Ricardo N. MONLA (rmonla@gmail.com)<®>"
__fmod__ = "2018-01-14"
__ver__  = "1.0.1"

"""
/*<®> Administrador de Argumentos <®>*/
  /*<®> Descripción <®>*/
    Script con el que administro los argumentos o parámetros del proyecto.
  
  /*<®> Items relizados y pendientes <®>*/
    [x] fx 'rmArgs' que cargador de parámetros del proyecto.
    [ ] Validación de parámetros.


  /*<®> Copyright (c) 2018 Ricardo N. MONLA (rmonla@gmail.com) <®>*/
"""

from optparse import OptionParser

def rmArgs():
    prmtros = OptionParser(
                      usage   = "usage: %prog [opciones]",
                      version = "%prog "+ __ver__ +"")
    prmtros.add_option("-t", "--tpo",
                      action  = "store",
                      dest    = "tpo",
                      default = "d",
                      help    = "[\"d\"] Tipo de busqueda f-> Archivos, d-> Directorios.")
    prmtros.add_option("-p", "--pth",
                      action  = "store", 
                      dest    = "pth",
                      default = ".",
                      help    = "[\".\"] Path donde se realiza la busqueda.")
    prmtros.add_option("-r", "--rgx",
                      action  = "store", 
                      dest    = "rgx",
                      default = "",
                      help    = "[\"\"]  String con los comodines regex (Ej: \".*(IMG-).*\").")
    
    (opts, args) = prmtros.parse_args()

    # /*<®> Validación <®>*/

    # if len(args) != 1:
    #     prmtros.error("wrong number of arguments")

    # print opts
    # print args

if __name__ == '__main__':
    rmArgs()



    # prmtros.add_option("-x", "--xhtml",
    #                   action="store_true",
    #                   dest="xhtml_flag",
    #                   default=False,
    #                   help="create a XHTML template instead of HTML")
    # prmtros.add_option("-c", "--cssfile",
    #                   action="store", # optional because action defaults to "store"
    #                   dest="cssfile",
    #                   default="style.css",
    #                   help="CSS file to link",)