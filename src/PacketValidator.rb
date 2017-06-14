#!/usr/bin/ruby
# encoding: UTF-8

class PacketValidator

	def initialize
		@validCommands = ["CREATE", "DELETE", "JOIN", "LOGIN", "ALIVE", "IMALIVE", "ERROR", "LOGGEDIN", "USERALREADYCONNECTED", "SAY", "MESSAGE"]
	end
	
	def validate(command)
		#puts "WALIDUJE " + command
		c = command
		args = command.split(" ")
		if(args.length > 1)
			command = args[0]
		end
		if @validCommands.include?(command.upcase)
			#puts "PRAWDA"
			return true
		else 
			#puts "FAŁSZ"
			return false
		end
	end

end