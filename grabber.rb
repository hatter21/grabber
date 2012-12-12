class Grabber
	require 'open-uri'
	@@http = []
	@@global_mass = ['http://forifish.ho.ua/']
	@@last_mass = []

	def grabber(level)
		for i in 1..level
			@@last_mass = []
			@@global_mass.each do |item|
				begin
                                	url = item.to_s
					page = open(url)
					text = page.read
					links = text.scan(/<a.*href=["'](.*)["']/)
					@@last_mass.concat(links)
                                rescue
					@@last_mass << "http address is invalid!"
                                end
			end
			@@last_mass.uniq!			
			@@global_mass = @@last_mass
			@@http << "level " + i.to_s + ":"
			@@http << @@last_mass
		end
	end 

	def open_file
			File.open("http.txt", "w") do |file|
			file.puts @@http
			end
	end

	def puts_file
		puts File.read("http.txt")
	end

end
f = Grabber.new
f.grabber(3)
f.open_file
f.puts_file
