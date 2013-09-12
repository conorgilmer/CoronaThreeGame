----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

--imports
local physics = require("physics")
-- start and set gravity
physics.start()
physics.setGravity(0, 9.8)

local background

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

function  mainmenu(event)
	if event.phase == "ended" then
	storyboard.gotoScene("sceneMenu")
    end
end

local function moveSquare(event)
	-- Doesn't respond if the game is ended
	--if not gameIsActive then return false end
    
	-- Only move to the screen boundaries
	if event.x >= 50 and event.x <= display.contentWidth - 50 then
		-- Update player x axis
		square.x = event.x
		square.y = event.y

	end
end

--Collision functon. Controls hitting the blocks and coins etc. Also resets the jumping, climbing a ladder and descending one - cg
	function onCollision(event)
                        
          
        local name1 = event.object1.name
        local name2 = event.object2.name

        print ("incollisison")
        print(name1)
        print(name2)
        if name1 == "circle" or name2=="circle" then
          	if name1=="circLine" or name2 =="circLine" then
           		print("GOTCHA Circle")
           		display.remove(event.object2); event.object2 = nil
                display.remove(event.object1); event.object1 = nil
                --  laserChannel = audio.play(gotchaSound)
                --changeText(-5)
    		end  
       	end 
        if name1 == "square" or name2=="square" then
          	if name1=="sqLine" or name2 =="sqLine" then
           		print("GOTCHA Square")
           		display.remove(event.object2); event.object2 = nil
                display.remove(event.object1); event.object1 = nil

    		end  
       	end 

        if name1 == "diamond" or name2=="diamond" then
          	if name1=="dLine" or name2 =="dLine" then
           		print("GOTCHA Diamond")
           		display.remove(event.object2); event.object2 = nil
                display.remove(event.object1); event.object1 = nil

    		end  
       	end 

end
                                                    
                  



function moveCircle(event)
	-- Doesn't respond if the game is ended
	--if not gameIsActive then return false end
    
	-- Only move to the screen boundaries
	if event.x >= 50 and event.x <= display.contentWidth - 50 then
		-- Update player x axis
		circle.x = event.x
		circle.y = event.y

	end
end

function moveDiamond(event)
	-- Doesn't respond if the game is ended
	--if not gameIsActive then return false end
    
	-- Only move to the screen boundaries
	if event.x >= 50 and event.x <= display.contentWidth - 50 then
		-- Update player x axis
		diamond.x = event.x
		diamond.y = event.y

	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
	-- Blue background
	background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(211, 215, 193)
	group:insert(background)

	-- Main Menu Button
    mmimg = display.newImageRect("mm.png", 150, 48)
    mmimg.x = display.contentWidth - 160
	mmimg.y = (display.contentHeight) - 70
	group:insert(mmimg)

	-- square outline
	sqLine = display.newImageRect("sqLine.png", 150, 150);
	sqLine.x = 373;
	sqLine.y = 181;
	sqLine.name="sqLine"

    physics.addBody(sqLine, "static", {bounce=0})
	-- Square
	square = display.newImageRect("square.png", 150, 150);
	square.x = 600;
	square.y = 678;
	square.name = "square"
	physics.addBody(square, "dynamic", {bounce=0.2})
	-- Circle outline
	circLine = display.newImageRect("circleline.png", 150, 150);
	circLine.x = 181;
	circLine.y = 180;
	circLine.name="circLine"
    physics.addBody(circLine, "static", {bounce=0})
	-- circle positioning
	circle = display.newImageRect("circle.png", 150, 150);
	circle.x = 373;
	circle.y = 678;
	circle.name="circle"
	physics.addBody(circle, "dynamic", {bounce=0.2})
	-- diamond outline
	dLine = display.newImageRect("diamondL.png", 150, 150);
	dLine.x = 600;
	dLine.y = 181;
	dLine.name="dLine"

    physics.addBody(dLine, "static", {bounce=0})
	-- daimond
	diamond = display.newImageRect("diamond.png", 150, 150);
	diamond.x = 144;
	diamond.y = 678;
	diamond.name="diamond"
	physics.addBody(diamond, "dynamic", {bounce=0.2})

    -- Add Floor
    local floor = display.newImage("floor.png")
    floor.y = display.contentHeight - 150
    physics.addBody(floor, "static", {bounce= 0})

	-- define boundries rectangles
	local leftWall = display.newRect(0, 0, 1, display.contentHeight)
	physics.addBody(leftWall, "static", {bounce=0.1})
	local rightWall = display.newRect(display.contentWidth, 0, 1, display.contentHeight)
	physics.addBody(rightWall, "static", {bounce=0.1})	
	--local ceiling = display.newRect(0, 0, display.contentWidth, 1)
	--physics.addBody(ceiling, "static", {bounce=0.1})

    group:insert(floor)
	group:insert(circle)
	group:insert(square)
	group:insert(sqLine)
	group:insert(circLine)
	group:insert(diamond)
	group:insert(dLine)

end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	mmimg:addEventListener("touch", mainmenu)

	square:addEventListener("touch", moveSquare)
	circle:addEventListener("touch", moveCircle)
	diamond:addEventListener("touch", moveDiamond)



	Runtime:addEventListener("collision",onCollision)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	--Stop any loops/listeners from running
	Runtime:removeEventListener( "collision", onCollision )

	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
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