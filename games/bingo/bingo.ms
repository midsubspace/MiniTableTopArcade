clear
game={}
sounds={}
sounds.ball_spin=file.loadSound("/usr/bingo/sounds/bingo_tumble.wav")
game.caller={}
game.location={"name":""}
names=file.readLines("/usr/games/bingo/npcs/names.txt")
locations=file.readLines("/usr/games/bingo/locations/places.txt")
if locations==null or locations.len==0 then
    print "/usr/games/bingo/locations/places.txt is blank or missing"
else
    while game.location.name==""
        game.location.name=locations[floor(rnd*locations.len)]
    end while
end if
if names==null or names.len==0 then
    print "/usr/games/bingo/npc/names.txt is either blank or missing"
else
    game.caller.name=names[floor(rnd*names.len)]
end if
game.player={}
game.player.name="Dev"//input("What's your name?");clear
print "Welcome to "+game.location.name+", "+game.player.name+char(10)+"The Caller for this evening is "+game.caller.name

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
game.dis_board("player")
bcall=input("Bcall> ")
game.check_board(bcall,"player")
game.dis_board("player")