----------------------------------------------------------------------------------
--
-- sceneMenu.lua
-- by Conor Gilmer
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


--Create a constantly looping background sound...
--local bgSound = audio.loadStream("bgSound.mp3")
--audio.reserveChannels(1)   --Reserve its channel
--audio.play(bgSound, {channel=1, loops=-1}) --Start looping the sound.


----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function  game1(event)
	if event.phase == "ended" then
	storyboard.gotoScene("sceneGame1")
    end
end

function  game2(event)
	if event.phase == "ended" then
	storyboard.gotoScene("sceneGame2")
    end
end

function  game3(event)
	if event.phase == "ended" then
	storyboard.gotoScene("sceneGame3")
    end
end




-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view	
	audio.setVolume( 1, { channel=1 } )
	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	print "create menu"
	background = display.newImageRect("bg.png", 768, 1024)
	background.x = display.contentWidth/2
	background.y = display.contentHeight/2
	group:insert(background)


	tmmimg = display.newImageRect("3gamemenu.png", 700, 166)
    tmmimg.x = display.contentWidth/2
	tmmimg.y = display.contentHeight/5
	group:insert(tmmimg)



	g1img = display.newImageRect("gameone.png", 484, 76)
    g1img.x = display.contentWidth/2
	g1img.y = (display.contentHeight *2)/5
	group:insert(g1img)

	g2img = display.newImageRect("gametwo.png", 514, 76)
    g2img.x = display.contentWidth/2
	g2img.y = (display.contentHeight *3)/5
	group:insert(g2img)

	g3img = display.newImageRect("gamethree.png", 552, 76)
    g3img.x = display.contentWidth/2
	g3img.y = (display.contentHeight *4)/5
	group:insert(g3img)




    -- Sound ON/OFF text in the bottom-right corner
    soundText = display.newText(group, "Music: On ",380,290,"Arial",30)
	--livesText:setReferencePoint(display.contentWidth/2); 
	soundText:setTextColor(50)
	soundText.x = 150; soundText.y = display.contentHeight - 50
    --soundText = display.newText(screenGroup, "Sound: ON", 380, 290, 100, 20, "Arial", 15)
    --soundText:setTextColor(50)

    function soundOnOff()
        if audioPause then
           print("Music ON")
            audio.setMaxVolume(1)
            soundText.text = "Music: ON"
            audioPause = false
            audio.play(bgSound, {channel=1, loops=-1}) 
        else
            print("Music OFF")
            audio.setMaxVolume(0) -- Handy option to turn off the music and every sound effects.
            audioPause = true
            audio.stop();
            soundText.text = "Music: OFF"
        end

    end
    -- This listener connect action to our button.
    soundText:addEventListener("tap", soundOnOff)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view	
	print "enter menu"
	storyboard.removeAll()
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	--message:setTextColor(250,0,0)
	g1img:addEventListener("touch", game1)
	g2img:addEventListener("touch", game2)
	g3img:addEventListener("touch", game3)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	print "exit menu"
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	--audio.stop(1)
	--bgSound=nil
	Runtime:removeEventListener("touch",game1)
	Runtime:removeEventListener("touch",game2)
	Runtime:removeEventListener("touch",game3)
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
    print "destroy menu"	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
    audio.dispose(bgSound)
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene