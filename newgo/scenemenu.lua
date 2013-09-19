----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

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

function right (event)
	if event.phase == "ended" then
	storyboard.gotoScene( "scene1" )
    end
end


function left (event)
	if event.phase == "ended" then
	storyboard.gotoScene( "scene3" )
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	print "create scene menu	"

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	background = display.newImageRect ( "sceneBG.png", 768,1024)
	background.x = display.contentWidth/2
	background.y = display.contentHeight/2
	group:insert(background)

	message = display.newText( "Scene 1", 250, 250, nil, 60 )
	message.x = display.contentWidth/2
	message.y = display.contentHeight/2
	group:insert(message)

	leftArrow = display.newImageRect ( "arrowLeft.png", 120,120)
	leftArrow.x = display.contentWidth/2 - 250
	leftArrow.y = display.contentHeight/2 + 350
    group:insert(leftArrow)

    rightArrow = display.newImageRect ( "arrowRight.png", 120,120)
    rightArrow.x = display.contentWidth/2 + 250
	rightArrow.y = display.contentHeight/2 + 350
    group:insert(rightArrow)


	-----------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	print "enter scene menu"
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	message:setTextColor( 255,0,0 )


	leftArrow:addEventListener ("touch", left)
	rightArrow:addEventListener ("touch", right)
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	print "exit scene menu"
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	print "destroy scene menu"
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
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