#!/usr/bin/ruby
# encoding: UTF-8

require './ChessServer'
require './ChessClient'
require 'io/console'

#
#	problem kiedy klient sie force rozlacza i nie wysyla IAMALIVe
# 	stworz klasy do pakietow
# 	ogarnij czemu klient nie wysyla lub odbiera im alive
#	
#

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