print "Imported MSL Libary"
sprite_xy=function
    wasDown=false
    while true
        isDown=mouse.button
        if isDown and not wasDown then print "X:"+mouse.x+"Y:"+mouse.y
        wasDown=isDown
        yield
    end while
end function
Sprite.is_Clicked=function
// Ensure the self has a bounds.
	if not self.localBounds then
		self.localBounds = new Bounds
		self.localBounds.width = self.image.width
		self.localBounds.height = self.image.height
	end if
	// Track the mouse until the button is released,
	// showing the button as "pressed" whenever the
	// mouse is within the self bounds.
	while mouse.button
		if self.contains(mouse) then
			self.tint = color.silver
		else
			self.tint = color.white
		end if
		yield
	end while
	self.tint = color.white
	// Return whether the mouse was released within bounds.
	return self.contains(mouse)
end function

// Logging system from https://github.com/David-Avila/The-Slow-Library/tree/main

logFile = "log.txt"

recordStartup = function
	content = []

	content.push "Starting up..."

	file.writeLines logFile, content
end function

recordStartup

msl.log = function(msg)
	content = file.readLines(logFile)

	content.push "INFO: " + msg

	file.writeLines logFile, content
end function

msl.warn = function(msg)
	content = file.readLines(logFile)

	content.push "WARNING: " + msg

	file.writeLines logFile, content
end function

msl.error = function(msg)
	content = file.readLines(logFile)

	content.push "ERROR: " + msg

	file.writeLines logFile, content
end function

msl.fatal = function(msg)
	content = file.readLines(logFile)

	content.push ("FATAL: " + msg).upper

	file.writeLines logFile, content
end function