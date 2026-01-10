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

percentToVolume = function(percent) //converts 100% to vol number
    if percent < 0 then percent = 0
    if percent > 100 then percent = 100
    return percent / 100
end function


// Logging system

logFile = "log.txt"
prevLogFile = "prev_log.txt"

recordStartup = function
	content = []

	if file.exists(logFile) then
		if file.exists(prevLogFile) then file.delete(prevLogFile)
		file.copy logFile, prevLogFile
	end if

	content.push "Starting up..."

	file.writeLines logFile, content
end function

recordStartup

log = function(msg)
	content = file.readLines(logFile)

	content.push "INFO at " + round(time, 3) + "s: " + msg

	file.writeLines logFile, content
end function

warn = function(msg)
	content = file.readLines(logFile)

	content.push "WARNING at " + round(time, 3) + "s: " + msg

	file.writeLines logFile, content
end function

error = function(msg)
	content = file.readLines(logFile)

	content.push "ERROR at " + round(time, 3) + "s: " + msg

	file.writeLines logFile, content
end function

fatal = function(msg)
	content = file.readLines(logFile)

	content.push ("FATAL at " + round(time, 3) + "s: " + msg).upper

	file.writeLines logFile, content
end function