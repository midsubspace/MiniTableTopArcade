clear
game={}
game.ballPool=["B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10", "B11", "B12", "B13", "B14", "B15", "I16", "I17", "I18", "I19", "I20", "I21", "I22", "I23", "I24", "I25", "I26", "I27", "I28", "I29", "I30", "N31", "N32", "N33", "N34", "N35", "N36", "N37", "N38", "N39", "N40", "N41", "N42", "N43", "N44", "N45", "G46", "G47", "G48", "G49", "G50", "G51", "G52", "G53", "G54", "G55", "G56", "G57", "G58", "G59", "G60", "O61", "O62", "O63", "O64", "O65", "O66", "O67", "O68", "O69", "O70", "O71", "O72", "O73", "O74", "O75"]
sounds={}
sounds.ball_spin=file.loadSound("/usr/games/bingo/sounds/bingo_tumble.wav")
game.caller={}
game.location={"name":""}
names=file.readLines("/usr/games/bingo/data/names.txt")
if names==null or names.len==0 then
    print "/usr/games/bingo/data/names.txt is either blank or missing"
else
    print "Loaded "+names.len+" Names"
    game.caller.name=names[floor(rnd*names.len)]
end if

locations=file.readLines("/usr/games/bingo/data/locations.txt")
if locations==null or locations.len==0 then
    print "/usr/games/bingo/data/locations.txt is blank or missing"
else
    print "Loaded "+locations.len+" Locations"
    while game.location.name==""
        game.location.name=locations[floor(rnd*locations.len)]
    end while
end if

game.caller.sayings=file.readLines("/usr/games/bingo/data/caller_sayings.txt")
if game.caller.sayings==null or names.len==0 then
    print "/usr/games/bingo/data/caller_sayings.txt is either blank or missing"
else
    print "Loaded "+game.caller.sayings.len+" Call Outs"
end if
wait 3;clear
game.player={}
game.player.name="Dev"//input("What's your name?");clear
print "Welcome to "+game.location.name+", "+game.player.name+char(10)+"The Caller for this evening is "+game.caller.name
game.call_ball=function()
    game.ballPool.shuffle
    return game.ballPool.pull
end function
game.gen_board=function
    board={
        "B": [],
        "I": [],
        "N": [],
        "G": [],
        "O": [],}
    gen_pool=function(s1=0,s2=1)
        pool=[]
        for i in range(s1,s2)
            pool.push(str(i))
        end for
        pool.shuffle
        return pool
    end function
    pool=gen_pool(1,15);board.B=[pool.pull,pool.pull,pool.pull,pool.pull,pool.pull]
    pool=gen_pool(16,30);board.I=[pool.pull,pool.pull,pool.pull,pool.pull,pool.pull]
    pool=gen_pool(31,45);board.N=[pool.pull,pool.pull,pool.pull,pool.pull,pool.pull]
    pool=gen_pool(46,60);board.G=[pool.pull,pool.pull,pool.pull,pool.pull,pool.pull]
    pool=gen_pool(61,75);board.O=[pool.pull,pool.pull,pool.pull,pool.pull,pool.pull]
    return board
end function
game.player.board=game.gen_board
game.dis_board=function(whose)
    print " B  I  N  G  O"
    for row in range(0,4)
        line=""
        for col in ["B","I","N","G","O"]
            val = game[whose].board[col][row]
            s=str(val)
            if s.len==1 then s=" "+s
            line=line+s+" "
        end for
        print line
    end for
end function
game.check_board=function(bcall,whose)
    letter=bcall.split("")[0]
    numbers=bcall.split("")
    if numbers.len==3 then
        numbers.pull
        numbers=numbers.join("")
    else if numbers.len==2 then
        numbers.pull
        numbers=numbers[0]
    end if
    for item in game[whose].board
        if item.key.lower==letter.lower then
            pool=item.value
            pool.replace(numbers,"X")
            game[whose].board[letter.upper]=pool
            break
        end if
    end for
end function

game.main_loop=function()
    while game.ballPool.len!=0
        wait 3
        clear
        game.dis_board("player")
        sounds.ball_spin.play
        wait 3
        bcall=game.call_ball
        sounds.ball_spin.stop
        game.caller.sayings.shuffle
        clear
        print game.caller.sayings[0]+" "+bcall+char(10)
        wait 3
        game.check_board(bcall,"player")
        clear
        game.dis_board("player")
        input("Ready for next round?")
    end while
end function

game.main_loop