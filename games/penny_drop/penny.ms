clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
msl={};import "msl"
game={}
game.pass=0
game.roll_history=[]
game.players={}
game.play_order=[]
game.players[1]={"name":"bot1","coins":5,"npc":1,"active":1}
game.players[2]={"name":"bot2","coins":5,"npc":1,"active":0}
game.players[3]={"name":"bot3","coins":5,"npc":1,"active":0}
game.players[4]={"name":"bot4","coins":5,"npc":1,"active":0}
game.players[5]={"name":"bot5","coins":5,"npc":1,"active":0}
game.players[6]={"name":"bot6","coins":5,"npc":1,"active":0}
game.players[7]={"name":"bot7","coins":5,"npc":1,"active":0}
game.players[8]={"name":"bot8","coins":5,"npc":1,"active":0}
game.players[9]={"name":"bot9","coins":5,"npc":1,"active":0}
game.players[10]={"name":"bot10","coins":5,"npc":1,"active":0}
names=file.readLines("/usr/games/penny_drop/data/names.txt")
if names==null or names.len==0 then
    msl.log "/usr/games/penny_drop/data/names.txt is either blank or missing"
else
    msl.log "Loaded "+names.len+" Names from /usr/games/penny_drop/data/names.txt"
end if
player_count=input("How Many Players? (2-10)").val
if player_count<2 then player_count=2
if player_count>10 then player_count=10
for i in range(1,player_count)
    game.players[i].active=1
end for
human_count=input("How Many Human Players Are Playing?(Max:"+(player_count)+")").val
if human_count!=0 then
    for i in range(1,human_count)
        if game.players[i].active==1 then
            game.players[i].npc=0
            game.players[i].name=input("What is Your Name Player "+i+" >")
        end if
    end for
end if
for i in game.players
    if i.value["active"]==1 then game.play_order.push(i)
end for
for i in game.play_order
    if i.value["npc"]==1 then
        i.value["name"]=names[floor(rnd*names.len)]
    end if
end for

game.board=["1","2","3","4","5","6"]
game.slots={1:0,2:0,3:0,4:0,5:0,6:0}
game.images={}
game.sprites={}
game.images.board=file.loadImage("/usr/games/penny_drop/images/board.png")
game.images.penny=file.loadImage("/usr/games/penny_drop/images/penny_slot.png")
game.drop_snd=file.loadSound("/usr/games/penny_drop/sounds/drop_sound.wav")
game.roll_snd=file.loadSound("/usr/games/penny_drop/sounds/die_roll.wav")
game.turn=game.players[1]
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
                print "Here's the Pennies"
                wait 4
                clear
                display(4).sprites=[]
                game.display_spr("board")
                game.display_spr "die"
                skip=1
                for i in game.slots
                    if i.value==1 then
                        game.turn.value.coins=game.turn.value.coins+1
                    end if
                end for
                game.slots={1:0,2:0,3:0,4:0,5:0,6:0}
                game.display_score
                game.pass=1
                return 
            end if
        end for
    end if
    if skip==1 then return
    if slot==1 then
        game.slots[slot]=1
        game.turn.value.coins=game.turn.value.coins-1
        penny_1=new Sprite
        penny_1.image=game.images.penny
        penny_1.name="penny_"+slot
        penny_1.scale=[0.5,0.5]
        penny_1.x=261
        penny_1.y=376
        display(4).sprites.push penny_1
    else if slot==2 then
        game.slots[slot]=1
        game.turn.value.coins=game.turn.value.coins-1
        penny_2=new Sprite
        penny_2.image=game.images.penny
        penny_2.name="penny_"+slot
        penny_2.scale=[0.5,0.5]
        penny_2.x=371
        penny_2.y=376
        display(4).sprites.push penny_2
    else if slot==3 then
        game.slots[slot]=1
        game.turn.value.coins=game.turn.value.coins-1
        penny_3=new Sprite
        penny_3.image=game.images.penny
        penny_3.name="penny_"+slot
        penny_3.scale=[0.5,0.5]
        penny_3.x=480
        penny_3.y=371
        display(4).sprites.push penny_3
    else if slot==4 then
        game.slots[slot]=1
        game.turn.value.coins=game.turn.value.coins-1
        penny_4=new Sprite
        penny_4.image=game.images.penny
        penny_4.name="penny_"+slot
        penny_4.scale=[0.5,0.5]
        penny_4.x=592
        penny_4.y=371
        display(4).sprites.push penny_4
    else if slot==5 then
        game.slots[slot]=1
        game.turn.value.coins=game.turn.value.coins-1
        penny_5=new Sprite
        penny_5.image=game.images.penny
        penny_5.name="penny_"+slot
        penny_5.scale=[0.5,0.5]
        penny_5.x=701
        penny_5.y=376
        display(4).sprites.push penny_5
    else if slot==6 then
        game.turn.value.coins=game.turn.value.coins-1
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
game.computer_logic=function()
    iam=game.turn
    pob=0//Pennies on board
    msl.log "There are "+pob+" Pennies on the board"
    for slot in game.slots
        if slot.value==1 then pob=pob+1
    end for
    //there are 5 slots that hold pennies
    game.pass=0
    if pob==5 then 
        game.pass=1
    else if pob==4 and iam.value.coins>1 then 
        game.pass=1
    else if pob==3 and iam.value.coins<3 then 
        game.pass=1
    else if pob==2 then
        game.pass=0
    else if pob==1 then
        game.pass=0
    end if
    return
end function
game.display_score=function()
    text.clear
    text.row = 30
    log game.play_order
    for player in game.play_order
        msl.log player
        if game.turn.value["name"]==player.value["name"] then
            text.color=color.yellow
            print player.value["name"]+"'s Coins: "+player.value["coins"]
        else
            text.color=color.white
            print player.value["name"]+"'s Coins: "+player.value["coins"]
        end if
    end for
    text.color=color.white
end function
game.roll=function(die=null)
    n=0
    while n!=10
        game.roll_snd.play
        game.die=ceil(rnd*6)
        game.display_spr "die"
        wait 0.1
        n=n+1
    end while
    if die==null then die=ceil(rnd*6)
    if die==0 then die=1
    game.roll_history.push(die+":"+game.turn.value["name"]+":"+game.turn.value["coins"])
    game.die=die
    game.dieface=char(9855+die)
end function
game.display_spr("board")
game.die=1
game.display_spr "die"
game.turn=game.play_order[0]
game.display_score
while true
    for player in game.play_order
        if player.value["coins"]==0 then
            clear
            game.display_score
            print player.value["name"]+" Has Won!"
            wait 4
            reset;load "/usr/shared/scripts/menu.ms";clear;run
        end if
    end for
    for player in game.play_order
        game.display_spr "die"
        game.turn=player
        game.display_score
        game.pass=0
        if player.value["npc"]==0 then
            while game.pass==0
                if player.value["coins"]==0 then
                    clear
                    game.display_score
                    print player.value["name"]+" Has Won!"
                    wait 4
                    reset;load "/usr/shared/scripts/menu.ms";clear;run
                end if
                if mouse.button then
                    if game.sprites.die.is_Clicked then
                        game.roll
                        game.display_spr "die"
                        game.display_penny game.die
                        game.display_score
                    end if
                    else if mouse.button(1) then
                        if game.sprites.die.is_Clicked then
                            game.pass=1
                            print player.value["name"]+" Has Chosen To Pass The Board"
                            wait 1
                            break
                        end if
                    end if
            end while
        else
            game.pass=0
            while game.pass==0
                if player.value["coins"]==0 then
                    clear
                    game.display_score
                    print player.value["name"]+" Has Won!"
                    wait 3
                    reset;load "/usr/shared/scripts/menu.ms";clear;run
                end if
                game.roll
                game.display_spr "die"
                game.display_penny game.die
                if game.pass==1 then break
                game.display_score
                print player.value["name"]+" Is Thinking..."
                wait 4
                game.computer_logic
                if game.pass==1 then 
                    print player.value["name"]+" Has Chosen To Pass The Board"
                    break
                end if
            end while
        end if
    end for
end while