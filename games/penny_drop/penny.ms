clear
game={}
game.player={"name":"Quinn"}
game.computer_one={"name":"Joe Strout"}
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
    for slot in game.board
        print slot
    end for
end function
game.roll=function
    die=ceil(rnd*6)
    if die==0 then die=1
    game.die=die
    game.dieface=char(9855+die)
end function
game.roll
print "You rolled a "+game.dieface+":"+game.die