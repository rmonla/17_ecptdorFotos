#!/usr/bin/env python
# -*- coding: utf-8 -*-

__aut__  = "<®>Copyright (c) 2018 Ricardo N. MONLA (rmonla@gmail.com)<®>"
__fmod__ = "2018-01-14"
__ver__  = "2.0.1"

"""
/*<®> Funsiones <®>*/
  /*<®> Descripción <®>*/
    En este archivo concentro la fxs comunes del proyecto.
  
  /*<®> Items relizados y pendientes <®>*/
    [x] fx 'rmMsj' Saca por pantalla el texto del mensaje
        enviado por parámetro y sale del programa si es solicitado.
"""

import sys

def msj(
  msj='',   # {str} [""]   Mensaje de salida.
  exit=None # {bol} [None] Sale del programa si es true.
  ):
  print """\

  """ + msj + """

  """
  if exit: sys.exit()
  
