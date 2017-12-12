#!/usr/bin/env ruby
require 'fileutils' 

class ReEncarpetar
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
		t = Time.new.strftime("%F_%T")
		puts "#{t} #{msg}"
	end
	def run(cmd)
		sleep 1 while !system(cmd)
	end
	def pthMini(pth = @dori)
		s   = "/"
		lst = pth.split(s)
		"#{lst[1]}#{s}**#{s}#{lst[-2..-1].join(s)}"
	end
	def subDir(pth)
		pth = "#{@ddst}/#{pth}"
		FileUtils.mkdir_p(pth) if !Dir.exist?(pth)
		pth
	end
	def desCompri
		n = 0
		for r in Dir.glob("#{@dori}/**/*.rar").sort
			log "Descomprimiendo => #{pthMini(r)}"
			run "rar x -inul -y #{r} #{subDir 'tmp'}" 
			n += 1
		end
		log "Se Descomprimieron => #{n} archivos"
	end
	def reorgArchs()
		n = 0
		for d in lstDirs(@dori)
			for f in lstArchs(d)
				fecha = File.atime(f).strftime("%F")
				anio  = File.atime(f).strftime("%Y")
				mes   = File.atime(f).strftime("%m")
				hora  = File.atime(f).strftime("%H")
				min   = File.atime(f).strftime("%M")
				seg   = File.atime(f).strftime("%S")
				ext   = File.extname(f)
				dnom  = d.split("/").at(-1)
				fpth  = "#{anio}/#{anio}-#{mes}/#{dnom}/#{fecha}/#{hora}"
				fdir  = subDir "#{fpth}"
				nom   = dnom+"-"+fecha+"_"+hora+":"+min+":"+seg
				fnew  = fdir+"/"+nom+ext
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
			pth   = File.absolute_path(f)
			fnom  = pth.split("/").at(-1)
			fdir  = pth.split("/").at(-2)
			lstPs = lstPs | pth.split( "/#{fdir}/#{fnom}" )
		end
		lstPs.sort
	end
	def compriDirs()
		for d in lstDirsComp()
			Dir.chdir(d)
			for dcomp in Dir.glob("*").sort.select { |f| File.ftype(f) == "directory" }
				log("Comprimiendo  => #{d}/#{dcomp}")
				run "rar a -df -inul #{dcomp}.rar #{dcomp}"
			end
		end
	end

end
dori = '/home/ftp'
ddst = '/home/samba/ditic/cams'
o = ReEncarpetar.new(dori, ddst)
o.reorgArchs
o.compriDirs
# o.compriTmp
# o.compriSubDir("/home/samba/ditic/cams/tmp/camguardia/2016-05-03/")

