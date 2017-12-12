#!/usr/bin/env ruby
require 'fileutils'

class ReNomYEncarp
	attr_accessor :dori
	attr_accessor :ddst

	def initialize(dori, ddst)
		dpri = Dir.pwd
		Dir.chdir(dori); @dori = Dir.pwd
		Dir.chdir(dpri)
		Dir.chdir(ddst); @ddst = Dir.pwd
	end
	def lstArchs(dir)
		Dir.chdir(dir)
		Dir.glob("*").select { |f| File.ftype(f) == "file" }
	end
	def lstDirs(dir)
		Dir.chdir(dir)
		Dir.glob("*").select { |f| File.ftype(f) == "directory" }
	end
	def subDir(pth)
		pth = "#{@ddst}/#{pth}"
		if !Dir.exist?(pth)
			FileUtils.mkdir_p(pth)
		end
		pth
	end
	def noPisar(fnom, fext)
		n = 0
		nom2 = ( fnom+fext )
		while File.exist?(nom2) do
		   n += 1
		   nom2 = "#{fnom}_#{n}#{fext}"
		end
		nom2
	end
	def movTemp()
		for d in lstDirs(@dori)
			dori = ( @dori+'/'+d )
			for f in lstArchs(dori)
				fori  = ( dori+'/'+f )
				fecha = File.atime(fori).strftime("%F")
				hora  = File.atime(fori).strftime("%H")
				min   = File.atime(fori).strftime("%M")
				seg   = File.atime(fori).strftime("%S")
				fext  = File.extname(fori)
				fnom  = d+"_"+fecha+"_"+hora+":"+min+":"+seg
				dtmp = subDir( ( "tmp/"+d ) )
				ddst = dtmp+"/"+fecha+"/"+hora
				fnew = ddst+"/"+fnom+fext
				# fnew = noPisar(fdst, fext)
				ddst = subDir( "tmp/"+d+"/"+fecha+"/"+hora )
				FileUtils.mv fori, fnew
				puts "#{fori} ==> #{fnew}" 
			end
		end
	end
	def compriSubDir(dir)
		Dir.chdir(dir)
		for d in lstDirs(dir)
			cmd = "rar a -df #{d}.rar #{d}"
			# cmd = "rar a -df -inul #{d}.rar #{d}"
			exec( cmd )
		end
	end
	def compriTmp()
		dtmp = "#{@ddst}/tmp"
		for d1 in lstDirs("#{dtmp}")
			for d2 in lstDirs("#{dtmp}/#{d1}")
				compriSubDir("#{dtmp}/#{d1}/#{d2}")
			end
		end
	end
end
dori = '/home/ftp'
ddst = '/home/samba/ditic/cams'
o = ReNomYEncarp.new(dori, ddst)
o.movTemp
# o.compriTmp
# o.compriSubDir("/home/samba/ditic/cams/tmp/camguardia/2016-05-03/")

