#!/usr/bin/ruby

require './ChessServer'
require './ChessClient'
require 'io/console'

class Main
	def initialize
		@classes = Hash.new
		@classes.store('k', ChessClient.new)
		@classes.store('s', ChessServer.new)
	end
	def run	
		begin			
			puts "Witaj!\nChcesz uruchomić klienta czy serwer? Wpisz k jeżeli klient lub s jeżeli serwer i naciśnij ENTER."
			answer = STDIN.getch
		end until @classes[answer] != nil
		@classes[answer].start
	end
end

def startProgram
	main = Main.new
	main.run
end

startProgram