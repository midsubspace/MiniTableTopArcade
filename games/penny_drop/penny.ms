clear
game={}
game.player={"name":"Quinn"}
game.computer_one={"name":"Joe Strout"}
game.board=["1","2","3","4","5","6"]
game.dis_board=function()
    game.slots={"1":0,"2":0,"3":0,"4":0,"5":0,"6":0}
    for slot in game.board
        print slot
    end for
end function
game.roll=function
    die=ceil()
end function
game.dis_board