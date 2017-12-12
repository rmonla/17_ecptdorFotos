#!/usr/bin/env ruby
require 'fileutils'

class ReOrgDeRars
	attr_accessor :dori
	attr_accessor :ddst

	def initialize(dori, ddst)
		@dori = File.absolute_path(dori)
		@ddst = File.absolute_path(ddst)

	end
	def reOrg
		desCompri

	end
	def lstArchs(dir, bus = '.jpg')
		lst = (Dir.glob("#{dir}/*#{bus}").select { |f| File.ftype(f) == "file" }).sort
		log "Encontrados => #{lst.count} archivos con el criterio ->#{bus}<- dentro de ->#{pthMini(dir)}<-"
		lst
	end
	def lstDirs(dir)
		lst = (Dir.glob("#{dir}/*").select { |f| File.ftype(f) == "directory" }).sort
		log "Encontrados => #{lst.count} directorios dentro de ->#{pthMini(dir)}<-"
		lst
	end
	def log(msg)
		t = Time.new.strftime("%F_%T")
		puts "#{t} #{msg}"
	end
	def run(cmd)
		sleep 1 while !system(cmd)
	end
	def subDir(pth)
		pth = "#{@ddst}/#{pth}"
		FileUtils.mkdir_p(pth) if !Dir.exist?(pth)
		pth
	end
	def pthMini(pth = @dori)
		s   = "/"
		lst = pth.split(s)
		"#{lst[1]}#{s}**#{s}#{lst[-2..-1].join(s)}"
	end
	def desCompri
		n = 0
		for r in lstArchs @dori, "*/*.rar"
			log "Descomprimiendo => #{pthMini(r)}"
			dst1 = subDir 'tmp'
			run "rar x -inul -y #{r} #{dst1}"
			dst4 = subDir "reorg"
			reOrgArchs(dst1, dst4)
			FileUtils.remove_file(r) 
			n += 1
		end
		log "Se Descomprimieron => #{n} archivos."
	end
	def reOrgArchs(dori = @dori, ddst = @ddst, bus = '*/*.jpg')
		n = 0
		# for d in lstDirs dori
			for f in lstArchs dori, bus
				fecha = File.atime(f).strftime("%F")
				anio  = File.atime(f).strftime("%Y")
				mes   = File.atime(f).strftime("%m")
				hora  = File.atime(f).strftime("%H")
				min   = File.atime(f).strftime("%M")
				seg   = File.atime(f).strftime("%S")
				ext   = File.extname(f)
				# dnom  = "caminfoaula"
				dnom  = "camguardia"
				# dnom  = d.split("/").at(-1)
				fpth  = "#{anio}/#{anio}-#{mes}/#{dnom}/#{fecha}/#{hora}"
				fdir  = subDir "#{fpth}"
				nom   = dnom+"-"+fecha+"_"+hora+":"+min+":"+seg
				fnew  = fdir+"/"+nom+ext
				FileUtils.mv f, fnew
				n += 1
			end
		# end
		 log("Reorganizados => #{n} archivos.") if n > 0
	end
end

dori = ARGV[0]
ddst = ARGV[1]
o = ReOrgDeRars.new(dori, ddst)
o.reOrg


# class ComprimirDirJpg
# 	attr_accessor :dori
# 	attr_accessor :ddst

# 	def initialize(dori, ddst)
# 	end
# 	def run
# 	end
# 	def rars
# 		Dir.glob("#{@dori}/**/*.rar").sort
# 	end
# 	def compriDir
# 		puts Dir.glob("#{@dori}/**/*.3gp").first
# 	end
# end

# o = ComprimirDirJpg.new(ARGV[0], ARGV[1])
# o.run