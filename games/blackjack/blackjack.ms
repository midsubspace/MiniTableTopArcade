clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
game={}
game.players={}
game.play_order=[]
start_money=500
game.players[1]={"name":"bot1","coins":start_money,"npc":1,"active":0}
game.players[2]={"name":"bot2","coins":start_money,"npc":1,"active":0}
game.players[3]={"name":"bot3","coins":start_money,"npc":1,"active":0}
game.players[4]={"name":"bot4","coins":start_money,"npc":1,"active":0}
game.players[5]={"name":"bot5","coins":start_money,"npc":1,"active":0}
game.players[6]={"name":"bot6","coins":start_money,"npc":1,"active":0}
game.players[7]={"name":"bot7","coins":start_money,"npc":1,"active":0}
game.players[8]={"name":"bot8","coins":start_money,"npc":1,"active":0}
game.players[9]={"name":"bot9","coins":start_money,"npc":1,"active":0}
game.players[10]={"name":"bot10","coins":start_money,"npc":1,"active":0}
names=file.readLines("/usr/games/blackjack/data/names.txt")
if names==null or names.len==0 then
    msl.log "/usr/games/blackjack/data/names.txt is either blank or missing"
else
    msl.log "Loaded "+names.len+" Names from /usr/games/blackjack/data/names.txt"
end if