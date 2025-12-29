clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
game={}
game.roll_history=[]
game.player={"name":"Dev","coins":12}
game.computer_one={"name":"Computer 1","coins":12}
game.board=["1","2","3","4","5","6"]
game.slots={1:0,2:0,3:0,4:0,5:0,6:0}
game.images={}
game.sprites={}
game.images.board=file.loadImage("/usr/games/penny_drop/images/board.png")
game.images.penny=file.loadImage("/usr/games/penny_drop/images/penny_slot.png")
game.drop_snd=file.loadSound("/usr/games/penny_drop/sounds/drop_sound.wav")
game.turn="player"
game.display_spr=function(sprite=null)
    if sprite==null then input("ERR:display_spr: No sprite var was passed to function notify dev")
    if sprite=="board" then
        game.sprites.board=new Sprite
        game.sprites.board.image=game.images[sprite]
        game.sprites.board.scale=[0.5,0.5]
        game.sprites.board.x=480
        game.sprites.board.y=320
        game.sprites.board.name="board"
        display(4).sprites.push game.sprites.board
    else if sprite=="die" then
        game.sprites.die=new Sprite
        game.images.die=file.loadImage("/usr/games/penny_drop/images/"+game.die+".png")
        game.sprites.die.image=game.images[sprite]
        game.sprites.die.x=458
        game.sprites.die.y=129
        //spr.scale=[0.5,0.5]
        game.sprites.die.name=game.die+"_die"
        display(4).sprites.push game.sprites.die
    else
        print crash
    end if
end function

game.display_penny=function(slot=null)
    //print "You rolled a "+game.dieface+":"+game.die
    skip=0
    if game.die!=6 then
        for i in game.slots
            if game.slots[game.die]==1 and skip==0 then
                print "You Lost Take all the pennys on the board!"
                wait 5
                clear
                display(4).sprites=[]
                game.display_spr("board")
                game.display_spr "die"
                skip=1
                for i in game.slots
                    if i.value==1 then
                        if game.turn=="player" then game.player.coins=game.player.coins+1
                    end if
                end for
                game.slots={1:0,2:0,3:0,4:0,5:0,6:0}
                return
            end if
        end for
    end if
    if skip==1 then return
    if slot==1 then
        game.slots[slot]=1
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_1=new Sprite
        penny_1.image=game.images.penny
        penny_1.name="penny_"+slot
        penny_1.scale=[0.5,0.5]
        penny_1.x=261
        penny_1.y=376
        display(4).sprites.push penny_1
    else if slot==2 then
        game.slots[slot]=1
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_2=new Sprite
        penny_2.image=game.images.penny
        penny_2.name="penny_"+slot
        penny_2.scale=[0.5,0.5]
        penny_2.x=371
        penny_2.y=376
        display(4).sprites.push penny_2
    else if slot==3 then
        game.slots[slot]=1
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_3=new Sprite
        penny_3.image=game.images.penny
        penny_3.name="penny_"+slot
        penny_3.scale=[0.5,0.5]
        penny_3.x=480
        penny_3.y=371
        display(4).sprites.push penny_3
    else if slot==4 then
        game.slots[slot]=1
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_4=new Sprite
        penny_4.image=game.images.penny
        penny_4.name="penny_"+slot
        penny_4.scale=[0.5,0.5]
        penny_4.x=592
        penny_4.y=371
        display(4).sprites.push penny_4
    else if slot==5 then
        game.slots[slot]=1
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_5=new Sprite
        penny_5.image=game.images.penny
        penny_5.name="penny_"+slot
        penny_5.scale=[0.5,0.5]
        penny_5.x=701
        penny_5.y=376
        display(4).sprites.push penny_5
    else if slot==6 then
        if game.turn=="player" then 
            game.player.coins=game.player.coins-1
        else if game.turn=="Computer One" then
            game.computer_one.coins=game.computer_one.coins-1
        end if
        penny_6=new Sprite
        penny_6.image=game.images.penny
        penny_6.name="penny_"+slot
        penny_6.scale=[0.5,0.5]
        penny_6.x=480
        penny_6.y=305
        display(4).sprites.push penny_6
        wait 0.5
        display(4).sprites.pop
        game.drop_snd.play
    else
        print display_penny_crash
    end if
end function

game.display_score=function()
    print  game.player.name+"'s Coins: "+game.player.coins
    print "Computer Coins: "+game.computer_one.coins
    print "Playing: "+game.turn
end function
game.roll=function(die=null)
    if die==null then die=ceil(rnd*6)
    if die==0 then die=1
    game.roll_history.push(die)
    game.die=die
    game.dieface=char(9855+die)
end function
game.display_spr("board")
game.die=1
game.display_spr "die"
game.display_score
while true
    if mouse.button then
        if game.sprites.die.isClicked then
            game.roll
            game.display_spr "die"
            game.display_penny game.die
            game.display_score
        end if
    end if
end while