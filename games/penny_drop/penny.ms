clear
game={}
game.player={"name":"Dev","coins":12}
game.computer_one={"name":"Computer 1","coins":12}
game.board=["1","2","3","4","5","6"]
game.sprites={}
game.sprites.board=file.loadImage("/usr/games/penny_drop/images/board.png")

sp=new Sprite
sp.image=game.sprites.board.getImage()
sp.x=480
sp.y=320
sp.scale=[0.5,0.5]
display(4).sprites.push sp

game.dis_board=function()
    game.slots={"1":0,"2":0,"3":0,"4":0,"5":0,"6":0}
    print  game.player.name+"'s Coins: "+game.player.coins
    print "Computer Coins: "+game.computer_one.coins
    line=""
    for slot in game.board
        line=line+slot+" "
    end for
    print line+char(10)
end function
game.roll=function
    die=ceil(rnd*6)
    if die==0 then die=1
    game.die=die
    game.dieface=char(9855+die)
end function
game.dis_board
game.roll
print "You rolled a "+game.dieface+":"+game.die