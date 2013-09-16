----------------------------------------------------------------------------------
--
-- sceneGame1.lua
-- by Conor Gilmer
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local background
local tapSound 
local tapChannel=4
----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function  mainmenu(event)
  tapChannel = audio.play( tapSound )
	if event.phase == "ended" then
	storyboard.gotoScene("sceneMenu")
    end
end

function  moveLeft(event)
	print 'Move Left'
	tapChannel = audio.play( tapSound )

	halfBoxHeight = 96/2
	leftBound = 96
	if junkbox.x >= leftBound then
		junkbox.x = junkbox.x -25
	end
end

function  moveRight(event)
	print 'Move rightbtn'
    tapChannel = audio.play( tapSound )
	halfBoxHeight = 96/2
	rightBound = display.contentWidth - 96

	if junkbox.x <= rightBound then
		junkbox.x = junkbox.x +25
	end
end

function  moveUp(event)
	print 'Move up'
  tapChannel = audio.play( tapSound )
	halfBoxHeight = 96/2
	if junkbox.y >= 120 then
		junkbox.y = junkbox.y -25
	end
end

function  moveDown(event)
	print 'Move Down'
  tapChannel = audio.play( tapSound )
	halfBoxHeight = 96/2
	bottomBound = display.contentHeight - 196
	if junkbox.y <= bottomBound then
		junkbox.y = junkbox.y +25
	end
end

local function moveJunk(event)
	-- Doesn't respond if the game is ended
	--if not gameIsActive then return false end
    halfPlayerWidth = 96 
	-- Only move to the screen boundaries
	if event.x >= halfPlayerWidth and event.x <= display.contentWidth - halfPlayerWidth then
		if event.y >= halfPlayerWidth and event.y <= display.contentHeight - halfPlayerWidth then
		-- Update player x axis
		junkbox.x = event.x
		junkbox.y = event.y
	end
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
  -- Tap key Sound
  
	--Load the sounds.
	tapSound = audio.loadSound("kbtap.mp3")

  
  
	-- Blue background
	background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(21, 115, 193)
	group:insert(background)

	-- Main Menu Button
    mmimg = display.newImageRect("mm.png", 150, 48)
    mmimg.x = display.contentWidth - 120
	mmimg.y = (display.contentHeight) - 70
	group:insert(mmimg)

    -- Move Buttons
    leftbtn = display.newImageRect("left.png", 64, 64)
    leftbtn.x = (display.contentWidth/2) - 128
	leftbtn.y = (display.contentHeight) - 70
	group:insert(leftbtn)

	rightbtn = display.newImageRect("right.png", 64, 64)
    rightbtn.x = (display.contentWidth/2) + 128
	rightbtn.y = (display.contentHeight) - 70
	group:insert(rightbtn)

	upbtn = display.newImageRect("up.png", 64, 64)
    upbtn.x = (display.contentWidth/2) + 49
	upbtn.y = (display.contentHeight) - 70
	group:insert(upbtn)

	downbtn = display.newImageRect("down.png", 64, 64)
    downbtn.x = (display.contentWidth/2) - 49
	downbtn.y = (display.contentHeight) - 70
	group:insert(downbtn)

	-- Junk Box put in the middle
    junkbox = display.newImageRect("junkbox96.png", 96, 96)
    junkbox.x = (display.contentWidth) /2
	junkbox.y = (display.contentHeight) /2
	group:insert(junkbox)


end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	mmimg:addEventListener("touch", mainmenu)
	leftbtn:addEventListener("touch", moveLeft)
	rightbtn:addEventListener("touch", moveRight)
	upbtn:addEventListener("touch", moveUp)
	downbtn:addEventListener("touch", moveDown)
	junkbox:addEventListener("touch", moveJunk)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	-- cleanup
	-- Remove Sound
    audio.dispose( tapSound ); tapSound = nil;
  
  
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