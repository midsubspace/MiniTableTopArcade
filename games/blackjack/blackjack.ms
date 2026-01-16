clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
game={}
game.name="blackjack"
game.players={}
game.play_order=[]
start_money=500
game.players[1]={"name":"bot1","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[2]={"name":"bot2","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[3]={"name":"bot3","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[4]={"name":"bot4","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[5]={"name":"bot5","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[6]={"name":"bot6","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[7]={"name":"bot7","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[8]={"name":"bot8","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[9]={"name":"bot9","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
game.players[10]={"name":"bot10","cards":[],"card_total":0,"money":start_money,"npc":1,"active":0}
names=file.readLines("/usr/games/"+game.name+"/data/names.txt")
if names==null or names.len==0 then
    msl.log "/usr/games/"+game.name+"/data/names.txt is either blank or missing"
end if
player_count=input("How Many Players? (2-10)> ").val
if player_count<2 then player_count=2
if player_count>10 then player_count=10
for i in range(1,player_count)
    game.players[i].active=1
end for
human_count=input("How Many Human Players Are Playing?(Max:"+(player_count)+")> ").val
if human_count>player_count then human_count=player_count
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
        names.shuffle
        name=names.pull
        i.value["name"]=name
    end if
end for

game.shuffle=function
    suits=["Hearts","Clubs","Diamonds","Spades"]
    ranks=["A","J","K","Q",2,3,4,5,6,7,8,9,10]
    game.deck=[]
    for suit in suits
        for rank in ranks
            game.deck.push("card"+suit+rank)
        end for
    end for
end function
game.shuffle
print game.deck.len
print game.deck