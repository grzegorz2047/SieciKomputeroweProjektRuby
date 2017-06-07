#!/usr/bin/ruby
# encoding: UTF-8

require 'socket'
require './PacketValidator'

class ChessClient
	
	def initialize
		@validator = PacketValidator.new
	end

	def start
		#begin
		#	puts "Wpisz ip serwera, do którego chcesz się połączyć:\n"
		#	@serverip = gets.chomp
		#end until not @serverip.is_a? Integer
		@serverip = "localhost"
		#begin
		#	puts "Wpisz na jakim porcie znajduje się serwer:\n"
		#	@serverport = gets.chomp
		#end until not @serverport.is_a? Integer
		@serverport = 2000
		begin
			puts "Wpisz na jakim porcie chcesz uruchomić clienta:\n"
			@port = gets.chomp
		end until not @port.is_a? Integer
		#@port = 2001
		
		@socket = UDPSocket.new
		@socket.bind(@hostname, @port)
		puts "Podaj swoj identyfikator w grze: \n"
		@nickname = gets.chomp
		sendToServer("LOGIN")
   
	
   		@thread = Thread.new {
			@thread.start(clientListenLoop)
		}
		@open = true
		@aliveThread = Thread.new {
			@thread.start(serverConnectionChecker)
		}
		while true
			puts "Wyslij komende do serwera:"
			@command = gets.chomp
			sendToServer(@command)
		end
		sleep(2)
		@socket.close
	end
	
	def serverConnectionChecker
		loop {
			if @connected 
				if isServerAlive
				else
					puts "Serwer zakonczyl polaczenie!"
					exit(0)
				end
			end
			sleep(1)
		}

	end
	
	def clientListenLoop
		puts "Uruchamiam nasluchiwanie przez klienta portu " + @port.to_s
		loop {
			begin
				msg = ""
				begin # emulate blocking recvfrom
				  p = @socket.recvfrom_nonblock(1024)  #=> ["aaa", ["AF_INET", 33302, "localhost.localdomain", "127.0.0.1"]]
				  msg = p[0].chomp
				rescue IO::WaitReadable
					IO.select([@socket])
					retry
				end
				puts "Cos dostalem jako client?"
				puts msg
				incomingCommand = msg
				if(!incomingCommand.empty?)
					#puts "2"
					args = incomingCommand.split(' ')
					if args.length == 0 
						return false
					end
					#puts "3"
					#puts "Komenda " + args[0]
					validated = @validator.validate(args[0])
					if !validated
						#puts "4"
						#msg_src.reply "NIEWIEM"
					else 
						#puts "5"
						puts "args0 to " + args[0]
						if args[0].include? "LOGGEDIN"
							@connected = true
							@lastPing = Time.now.to_i 
						end
						
						if args[0].include? "ALIVE"
							#puts "Mówię, że żyję tam " + " ip: " + p[1][2].to_s + " port: " + p[1][1].to_s
							@lastPing = Time.now.to_i 
							sendToServer("IMALIVE")
							
						end
						
					end
				else 
					puts "NO ELO"
				end
			rescue Exception => e
				puts e.to_s
				puts "Brak polaczenia z serwerem! Koncze dzialanie."
				exit(0)
			end
		}
	end
	
	def sendToServer(msg) 
		begin
			msg = @nickname + ";" + msg;
			@socket.send msg.encode('utf-8'), 0, @serverip, @serverport
		rescue Exception => e
			puts e.to_s
		end
	end
	def close 
		if open
			@socket.close   
		end
	end
	
	def isServerAlive
		#puts "czasy: " + Time.now.to_i.to_s + "stary: " + @lastAnswer.to_s
		return Time.now.to_i - @lastPing <= 3
	end
	
end
