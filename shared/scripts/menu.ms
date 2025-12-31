clear
if env.importPaths.indexOf("/usr/shared/scripts") == null then
    env.importPaths.push "/usr/shared/scripts"
end if
import "msl"
    main_menu={}
    main_menu.sprites={}
    main_menu.music={}
    main_menu.music.one=file.loadSound("/usr/shared/sounds/main_menu/main_music.wav")
    main_menu.music.one.play
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
display_credits=function
    clear
    credits = new Sprite
    credits.image=file.loadImage("/usr/shared/images/credits.png")
    credits.x=435
    credits.y=355
    credits.scale=[0.5,0.5]
    display(4).sprites.push credits
    wait 5
    reset;load "/usr/shared/scripts/menu.ms";clear;run
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
display_creditsbtn=function()
    credits=new Sprite
    credits.image=file.loadImage("/usr/shared/images/credits_btn.png")
    credits.scale=[0.4,0.4]
    credits.x=397
    credits.y=310
    main_menu.sprites.credits=credits
    display(4).sprites.push credits
end function
display_background
display_startbtn
display_settingsbtn
display_creditsbtn
while true
    if mouse.button then
        if main_menu.sprites.start.is_Clicked then
            display_games
        else if main_menu.sprites.settings.is_Clicked then
            continue
        else if main_menu.sprites.credits.is_Clicked then
            display_credits
        end if
    else if mouse.button(1) then 
        reset;load "/usr/shared/scripts/menu.ms";clear;run
    end if
end while