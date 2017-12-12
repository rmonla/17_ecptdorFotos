#!/usr/bin/env ruby

# /*****************************************************************************
# * ecptdorFotos.rb                                                            *
# *                           Encarpetador de Fotos                            *
# *                                                                            *
# * Desc:                                                                      *
# *         Script que desde una carpeta lee los archivos de imágenes y        *
# *         las mueve a otro destino ordenado según fecha.                     *
# *                                                                            *
# * Ver:    17.01                                                              *
# * Fecha:  2017-12-11                                                         *
# * Author: Ricardo MONLA rmonla@gmail.com                                     *
# ******************************************************************************/



require 'fileutils'

class EcptdorFotos
	attr_accessor :dori
	attr_accessor :ddst

	def initialize(dori, ddst)
		@dori = File.absolute_path(dori)
		@ddst = File.absolute_path(ddst)
	end
	
	def lstArchs(dir)
		Dir.glob("#{dir}/*").select { |f| File.ftype(f) == "file" }
	end
	
	def lstDirs(dir)
		Dir.glob("#{dir}/*").select { |f| File.ftype(f) == "directory" }
	end
	def log(msg)
		t = Time.now.strftime("%F_%H:%M:%S")
		puts "#{t}  #{msg}"
	end
	
	def subDir(pth)
		pth = "#{@ddst}/#{pth}"
		FileUtils.mkdir_p(pth) if !Dir.exist?(pth)
		pth
	end
	
	def moverArchivos()
		n = 0
		for d in lstDirs( @dori )
			for f in lstArchs( d )
				fnew_cab = d.split("/").at(-1)
				fnew_pth = File.mtime(f).strftime("%Y/%Y-%m/#{fnew_cab}/%F/%H")
				fnew_dir = subDir( fnew_pth ) 
				fnew_nom = File.mtime(f).strftime("%F_%T_%6N")+File.extname(f)
				fnew = "#{fnew_dir}/#{fnew_cab}-#{fnew_nom}"
				FileUtils.mv f, fnew
				n += 1
			end
		end
		 log("Reorganizados => #{n} archivos.") if n > 0
	end
	
	def lstDirsComp()
		lstPs = []
		lstFs = Dir.glob("#{@ddst}/**/*.jpg").sort
		lstFs.each do |f|
			pth  = File.absolute_path(f)
			fnom = pth.split("/").at(-1)
			fdir = pth.split("/").at(-2)
			lstPs  = lstPs | pth.split( "/#{fdir}/#{fnom}" )
		end
		lstPs.sort
	end
	
	def compriDirs()
		for d in lstDirsComp()
			Dir.chdir(d)
			for dcomp in Dir.glob("*").sort.select { |f| File.ftype(f) == "directory" }
				log("Comprimiendo  => #{d}/#{dcomp}")
				cmd = "rar a -df -inul #{dcomp}.rar #{dcomp}"
				while !system(cmd)
					sleep(1)
				end
			end
		end
	end

end

dori = '/home/ftp'
ddst = '/home/samba/ditic/cams'

o = EcptdorFotos.new(dori, ddst)
o.moverArchivos
o.compriDirs


# ddst = '/home/rmonla/Documentos/rmDocs/Scripts/prus/camsReorgDst'
# dori = '/home/rmonla/Documentos/rmDocs/Scripts/prus/dori'
# ddst = '/home/rmonla/Documentos/rmDocs/Scripts/prus/ddst'
# o.compriTmp
# o.compriSubDir("/home/samba/ditic/cams/tmp/camguardia/2016-05-03/")

