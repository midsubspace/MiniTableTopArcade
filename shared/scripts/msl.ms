sprite_xy=function
    wasDown=false
    while true
        isDown=mouse.button
        if isDown and not wasDown then print "X:"+mouse.x+"Y:"+mouse.y
        wasDown=isDown
        yield
    end while
end function