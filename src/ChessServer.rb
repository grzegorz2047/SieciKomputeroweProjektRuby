#!/usr/bin/ruby
# encoding: UTF-8

require 'socket'
require './PacketValidator'
require './ChessPlayer'

class ChessServer

	def initialize
		@listOfConnectedPlayers = []
		@validator = PacketValidator.new
	end

	def checkConnectedPeople
		puts "Uruchamiam sprawdzanie zycia clienta!"
		loop {
			@listOfConnectedPlayers.each { |client| 
				 
				begin 
					if client.isAlive  
						client.checkConnection
					else 
						puts "client " + client.getNick + " nie odpowiada!"
					end
				rescue
				end
			}
			@listOfConnectedPlayers.delete_if { |client| client.isAlive == false }
			numOfClients = @listOfConnectedPlayers.length
			if numOfClients == 0
				puts "Brak polaczonych klientow"
			else 
				puts "Do serwera jest aktualnie " + numOfClients.to_s + " polaczonych klientow"
			end
			sleep(2)						
		}
	end
	
	def start
		@hostname = "localhost"
		#begin
		#	puts "Wpisz na jakim porcie chcesz uruchomić serwer:\n"
		#	@port = gets.chomp
		#end until not @port.is_a? Integer
		@port = 2000
		@socket = UDPSocket.new
		@socket.bind(@hostname, @port)
		@thread = Thread.new {
			@thread.start(serverListenLoop)
		}
 
		puts "Serwer uruchomiony na porcie " + @port.to_s + "!"
		checkConnectedPeople
	end
	
	def serverListenLoop
		loop {
			msg = ""
			begin # emulate blocking recvfrom
				p = @socket.recvfrom_nonblock(1024)  #=> ["aaa", ["AF_INET", 33302, "localhost.localdomain", "127.0.0.1"]]
				msg = p[0].chomp
			rescue IO::WaitReadable
				IO.select([@socket])
				retry
			end
			puts "Cos dostalem jako serwer?"
			puts msg
			incomingCommand = msg
			#puts "1"
			if(!incomingCommand.empty?)
			#puts "2"
				args = incomingCommand.split(' ')
				if args.length == 0 
					return false
				end
				#puts "3"
				validated = @validator.validate(args[0])
				if !validated
					#puts "4"
					#msg_src.reply "NIEWIEM"
				else 
					#puts "5"
					if msg.include? "LOGIN"
						#puts "6"
						#nick = msg.split(" ")[0]
						player = ChessPlayer.new(@socket, p[1][2], p[1][1], msg)
						@listOfConnectedPlayers.push(player)
						player.sendToPlayer("LOGGEDIN")
						puts "Gracz " + msg + " polaczyl sie z serwerem!"
						#puts "7"
					end
					if msg.include? "IMALIVE"
						#puts "6"
						#nick = msg.split(" ")[0]
						@listOfConnectedPlayers.each { |client|
							client.refreshAlive
						}
						 
					end
					
				end
				
			end
			#puts "8"
			#msg_src.reply msg
		}
		#puts "7"
	end
	
	def stop
		@thread.terminate
	end
	
end

