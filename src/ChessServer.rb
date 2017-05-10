#!/usr/bin/ruby

require 'socket'

class ChessServer
	def initialize
		@listOfConnectedPlayers = []
	end

	def checkConnectedPeople
		loop {
			@listOfConnectedPlayers.each { |client| 
				puts "client!"  
				client.puts "HOUSTON ODBIOR!"
			}
			puts "test!"
			sleep(1)			
		}
	end
	
	def start
		begin
			puts "Wpisz na jakim porcie chcesz uruchomić serwer:\n"
			@port = gets.chomp
		end until not @port.is_a? Integer
			
		@server = TCPServer.open(@port)
		@thread = Thread.new {			
			loop {
			   Thread.start(@server.accept) do |client|
			   client.puts(Time.now.ctime)
			   client.puts "Polaczyles sie z serwerem gry w szachy!"
			   @listOfConnectedPlayers.push(client)
			   end
			}
		}
		puts "Serwer uruchomiony na porcie " + @port + "!"
		self.checkConnectedPeople
	end
	
	
	def stop
		@thread.terminate
	end
	
end