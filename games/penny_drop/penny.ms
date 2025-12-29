clear
env.importPaths.push("/usr/shared/scripts")
import "msl"
game={}
game.player={"name":"Dev","coins":12}
game.computer_one={"name":"Computer 1","coins":12}
game.board=["1","2","3","4","5","6"]
game.sprites={}
game.sprites.board=file.loadImage("/usr/games/penny_drop/images/board.png")
game.sprites.penny=file.loadImage("/usr/games/penny_drop/images/penny_slot.png")

game.display_spr=function(sprite=null)
    if sprite==null then input("ERR:display_spr: No sprite var was passed to function notify dev")
    spr=new Sprite
    spr.image=game.sprites[sprite]
    if sprite=="board" then
        spr.scale=[0.5,0.5]
        spr.x=480
        spr.y=320
    else
        print crash
    end if
    spr.name=sprite
    display(4).sprites.push spr
end function

game.display_penny=function(slot=null)
    spr=new Sprite
    spr.image=game.sprites.penny
    if slot==1 then
        spr.scale=[0.5,0.5]
        spr.x=261
        spr.y=376
    else if slot==2 then
        spr.scale=[0.5,0.5]
        spr.x=371
        spr.y=376
    else if slot==3 then
        spr.scale=[0.5,0.5]
        spr.x=480
        spr.y=371
    else if slot==4 then
        spr.scale=[0.5,0.5]
        spr.x=592
        spr.y=371
    else if slot==5 then
        spr.scale=[0.5,0.5]
        spr.x=701
        spr.y=376
    else if slot==6 then
        spr.scale=[0.5,0.5]
        spr.x=480
        spr.y=305
    else
        print display_penny_crash
    end if
    spr.name="penny_"+slot
    display(4).sprites.push spr
end function

game.dis_txtboard=function()
    game.slots={"1":0,"2":0,"3":0,"4":0,"5":0,"6":0}
    print  game.player.name+"'s Coins: "+game.player.coins
    print "Computer Coins: "+game.computer_one.coins
    line=""
    for slot in game.board
        line=line+slot+" "
    end for
    print line+char(10)
end function
game.roll=function(die=null)
    if die==null then die=ceil(rnd*6)
    if die==0 then die=1
    game.die=die
    game.dieface=char(9855+die)
    print "You rolled a "+game.dieface+":"+game.die
end function
game.dis_txtboard
game.display_spr("board")
for n in range(1,6)
    clear
    game.display_spr("board")
    game.roll(n)
    game.display_penny(game.die)
    wait 3
end for