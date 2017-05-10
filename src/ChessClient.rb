#!/usr/bin/ruby

require 'socket'

class ChessClient
	def start
		@hostname = 'localhost'
		@port = 2000	
		@socket = TCPSocket.open(@hostname, @port)

		puts "Klient polaczony z " + @hostname + " na porcie " + @port.to_s + "!"
		loop {				
			while line = @socket.gets
			   puts line.chop
			end
		}
		@socket.close               
	end
end