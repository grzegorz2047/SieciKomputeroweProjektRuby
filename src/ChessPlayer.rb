#!/usr/bin/ruby
# encoding: UTF-8

require 'socket'

class ChessPlayer

	def initialize(socket, ip, port, nick)
		@ip = ip
		@port = port
		@nick = nick
		@socket = socket
		refreshAlive
		puts "2223"
		
	end
	
	def sendToPlayer(msg) 
		begin
			puts "wysylam do " + @nick + " wiadomosc " + msg + " na ip " + @ip.to_s + " na porcie " + @port.to_s
			@socket.send msg.encode('utf-8'), 0, @ip, @port 
		rescue Exception => e
			puts e.to_s + " send to player"
			raise e   
		end
	end
	
	def checkConnection
		sendToPlayer("ALIVE")
	end
	
	
	def refreshAlive
		@lastAnswer = Time.now.to_i 
	end
	
	def getNick
		return @nick
	end
	
	def isAlive
		#puts "czasy: " + Time.now.to_i.to_s + "stary: " + @lastAnswer.to_s
		return Time.now.to_i - @lastAnswer <= 3
	end


end