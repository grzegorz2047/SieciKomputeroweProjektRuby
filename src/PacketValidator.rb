#!/usr/bin/ruby
# encoding: UTF-8

class PacketValidator

	def initialize
		@validCommands = ["CREATE", "DELETE", "JOIN", "LOGIN", "ALIVE", "IMALIVE", "ERROR", "LOGGEDIN"]
	end
	
	def validate(command)
		puts "WALIDUJE " + command
		if @validCommands.include?(command.upcase)
			#puts "PRAWDA"
			return true
		else 
			#puts "FAŁSZ"
			return false
		end
	end

end