#!/usr/bin/env ruby
require 'fileutils'

class ReNomYenCarpPorFMod
	attr_accessor :ori
	attr_accessor :dst

	def initialize(ori = ARGV[0]? ARGV[0] : ".", dst = ARGV[1]? ARGV[1] : "/tmp")
		pri = Dir.pwd
		Dir.chdir(ori); @ori = Dir.pwd
		Dir.chdir(pri)
		Dir.chdir(dst); @dst = Dir.pwd
	end
	def lstArchs()
		Dir.chdir(@ori)
		Dir.glob("*").select { |f| File.ftype(f) == "file" }
	end
	def noPisar(fnom, fext)
		n = 0
		nom2 = "#{fnom}#{fext}"
		while File.exist?(nom2) do
		   n += 1
		   nom2 = "#{fnom}_#{n}#{fext}"
		end
		nom2
	end
	def reNombrar()
		n = 0
		for f in lstArchs()
			fnom = File.mtime(f).strftime("%F_%T")
			fnom = "#{@ori}/#{fnom}"
			fext = File.extname(f)
			fnom = noPisar(fnom, fext)
			File.rename(f, fnom)
			n += 1
		end
		puts "Se renombraron #{n} archivos."
	end
	def subDir(pth)
		pth = "#{@dst}/#{pth}"
		if !Dir.exist?(pth)
			FileUtils.mkdir_p(pth)
		end
		pth
	end
	def enCarpetar()
		n = 0
		for f in lstArchs()
			anio = File.mtime(f).strftime("%Y")
			mes  = File.mtime(f).strftime("%m")
			dia  = File.mtime(f).strftime("%d")
			pth  = ( anio+"/"+anio+"-"+mes+"/"+anio+"-"+mes+"-"+dia )
			pth  = subDir(pth)
			fnom = ( pth+"/"+File.basename(f, ".*") )
			fext = File.extname(f)
			fnew = noPisar(fnom, fext)
			FileUtils.mv f, fnew
			n += 1
		end
		puts "Se encarpetaron #{n} archivos."

	end
end

o = ReNomYenCarpPorFMod.new()

o.reNombrar 
o.enCarpetar 

# ori = ARGV[0]? ARGV[0] : "."

# puts ori
# pthOri = Pathname.new(ori)
# puts pthOri.pwd()

# puts o.lstArchs 

# Dir.foreach("testdir") {|x| puts "Got #{x}" }
# 
# require 'fileutils'
# FileUtils.mv('/tmp/your_file', '/opt/new/location/your_file')
# FileUtils.mv 'badname.rb', 'goodname.rb'
# 
# d = Dir.new("testdir")
# d.each  {|x| puts ("Got " + x) }