#!/usr/bin/ruby

class Room 
	def initialize(owner)
		@owner = owner
	end
	def getOwner
		return @owner
	end
end
