clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
game={}
start_cash=1000
game.players={}
game.play_order=[]
game.players[1]={"name":"bot1","cash":start_cash,"npc":1,"active":0}
game.players[2]={"name":"bot2","cash":start_cash,"npc":1,"active":0}
game.players[3]={"name":"bot3","cash":start_cash,"npc":1,"active":0}
game.players[4]={"name":"bot4","cash":start_cash,"npc":1,"active":0}
game.players[5]={"name":"bot5","cash":start_cash,"npc":1,"active":0}
game.players[6]={"name":"bot6","cash":start_cash,"npc":1,"active":0}
game.players[7]={"name":"bot7","cash":start_cash,"npc":1,"active":0}
game.players[8]={"name":"bot8","cash":start_cash,"npc":1,"active":0}
game.players[9]={"name":"bot9","cash":start_cash,"npc":1,"active":0}
game.players[10]={"name":"bot10","cash":start_cash,"npc":1,"active":0}
names=file.readLines("/usr/games/blackjack/data/names.txt")
if names==null or names.len==0 then
    msl.log "/usr/games/blackjack/data/names.txt is either blank or missing"
else
    msl.log "Loaded "+names.len+" Names from /usr/games/blackjack/data/names.txt"
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
game.deck=[]//52 cards in format of suit:rank
game.deck_gen=function
    suit=["clubs","hearts","spades","diamonds"]
    rank=[2,3,4,5,6,7,8,9,10,"jack","queen","king","ace"]
    print "Opening Deck and Shuffling"
    for i in range(0,52)
        suit.shuffle;rank.shuffle
        card={suit[0]:rank[0]}
        while game.deck.indexOf(card)!=null 
            suit.shuffle;rank.shuffle
            card={suit[0]:rank[0]}
            yield
        end while
        game.deck.push(card) 
        yield
    end for
end function
game.deck_gen