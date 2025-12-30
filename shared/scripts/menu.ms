clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
    main_menu={}
    main_menu.sprites={}
display_background=function
    menu=new Sprite
    menu.image=file.loadImage("/usr/shared/images/main_menu_bkg.png")
    menu.x=432
    menu.y=314
    menu.scale=[0.5,0.5]
    main_menu.sprites.menu=menu
    display(4).sprites.push menu
end function

display_games=function
    clear
    display_background
    penny_drop=new Sprite
    penny_drop.image=file.loadImage("/usr/shared/images/penny_drop.png")
    penny_drop.x=414
    penny_drop.y=412
    penny_drop.scale=[0.5,0.5]
    display(4).sprites.push penny_drop
    while true
        if mouse.button then
            if penny_drop.is_Clicked then
                reset;load "/usr/games/penny_drop/penny.ms";clear;run
            end if
        else if mouse.button(1) then
            reset;load "/usr/shared/scripts/menu.ms";clear;run
        end if
    end while
end function

display_startbtn=function()
    start=new Sprite
    start.image=file.loadImage("/usr/shared/images/start_btn.png")
    start.x=404
    start.y=412
    main_menu.sprites.start=start
    display(4).sprites.push start
end function
display_settingsbtn=function()
    settings=new Sprite
    settings.image=file.loadImage("/usr/shared/images/settings_btn2.png")
    settings.x=411
    settings.y=353
    main_menu.sprites.settings=settings
    display(4).sprites.push settings
end function
    display_background
    display_startbtn
    display_settingsbtn
while true
    if mouse.button then
        if main_menu.sprites.start.is_Clicked then
            display_games
        else if main_menu.sprites.settings.is_Clicked then
            continue
        end if
    else if mouse.button(1) then 
        reset;load "/usr/shared/scripts/menu.ms";clear;run
    end if
end while