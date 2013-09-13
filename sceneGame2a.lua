----------------------------------------------------------------------------------
--
-- sceneGame2.lua
-- by Conor Gilmer
--
----------------------------------------------------------------------------------

--imports
local physics = require("physics")

-- start and set gravity
physics.start()
physics.setGravity(0, 9.8)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local background

--events
local gameLoop, onCollision
--local event

--Enemy
local options = 
{
	width = 96, height = 90,
	numFrames = 5,
	sheetContentWidth = 533,
	sheetContentHeight = 90
}
local enemySheet = graphics.newImageSheet( "sprite5.png", options)
local enemySprite = { name="run", start=1, count=2, time = 300, loopCount = 0 } 


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

function tapRemove(event)
	local name = event.target
    print ("removing obj")
--if (eventa.phase =="begin") then
--	timer.performWithDelay(1, function() self.removeSelf() end)
--end

   display.remove(name)
   -- event.target = nil

end

function  mainmenu(event)
	if event.phase == "ended" then
	storyboard.gotoScene("sceneMenu")
    end
end




-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- create the group
	--enemyGroup = display.newGroup();
	--group:insert(enemyGroup)

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
	-- Blue background
	background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	background:setFillColor(21, 415, 193)
	group:insert(background)


    -- Add Floor
    local floor = display.newImage("floor.png")
    floor.y = display.contentHeight - 100
    floor.name="floor"
    physics.addBody(floor, "static", {bounce= 0})
    group:insert(floor)

    -- Add Platform1
    platform1 = display.newImage("platform.png")
    platform1.y = display.contentHeight - 800
    platform1.x = display.contentWidth - 600
    physics.addBody(platform1, "static", {bounce= 0})
    group:insert(platform1)

    -- add sun
	sun1 = display.newImage("sun.png")
	sun1.x = platform1.x +100
	sun1.y = platform1.y  -100
	sun1.name="sun1"
	physics.addBody(sun1, "dynamic", {bounce=0})
	group:insert(sun1)

    -- Add Platform2
    platform2 = display.newImage("platform.png")
    platform2.y = display.contentHeight - 500
    platform2.x = display.contentWidth - 400
    physics.addBody(platform2, "static", {bounce= 0})    
    group:insert(platform2)

    -- Add Platform3
    platform3 = display.newImage("platform.png")
    platform3.y = display.contentHeight - 650
    platform3.x = display.contentWidth - 200
    physics.addBody(platform3, "static", {bounce= 0})
    group:insert(platform3)

    --print "add walker"
    -- add walker from left to right
    enemy = display.newSprite(enemySheet, enemySprite)
	enemy:setReferencePoint(display.BottomCenterReferencePoint)
	enemy.x = 300; enemy.y = display.contentHeight -120 
	enemy.name = "enemy"; 
	enemy.allowedMovement = true; 	enemy.speed = 10;  	enemy.travelled = 0;
	physics.addBody( enemy, "static", { isSensor = true } )
	enemy:setSequence("stand"); 
	enemy:play()
	--enemyGroup:insert(enemy)
    group:insert(enemy)
    gameIsActive = true

	-- Main Menu Button
    mmimg = display.newImageRect("mm.png", 150, 48)
    mmimg.x = display.contentWidth - 160
	mmimg.y = (display.contentHeight) - 50
	group:insert(mmimg)

end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	

storyboard.removeAll()

function createSplat(walker)
	
    splat = display.newImage("splat.png")
	splat.x = walker.x
	splat.y = walker.y
	--splash.rotation = math.random(-90,90)
	--splash.alpha = splashInitAlpha
	group:insert(splat)
	
	--transition.to(splash, {time = splashFadeTime, alpha = 0,  y = splash.y + splashSlideDistance, delay = splashFadeDelayTime, onComplete = function(event) splash:removeSelf() end})		
	
end


	--Collision functon. Controls hitting the blocks and coins etc. Also resets the jumping, climbing a ladder and descending one - cg
	function onCollision(event)
            
            
        if gameIsActive == true then
            local name1 = event.object1.name
            local name2 = event.object2.name
            --print "in collision and active" 
            --print (name1) 
            --print (name2)

            if name1== "floor" or name2=="floor" then
            	if name1=="sun1" or name2=="sun1" then
            		print "hit floor"
            		if name1=="sun1" then
            			print ("removing obj")
    					display.remove(event.object1)
    					event.object1 = nil

    				else 
    					print ("removing name 2 obj")
    					display.remove(event.object2)
    					event.object2= nil
            		end
            	end
            end
       
            if name1== "enemy" or name2=="enemy" then
            	if name1=="sun1" or name2=="sun1" then
            		print "Gotcha!!!"

            		if name1=="enemy" then
            			print ("removing obj")
            			createSplat(event.object1)
    					display.remove(event.object1)
    					event.object1 = nil
    					
    				else 
    					createSplat(event.object2)
    					print ("removing name 2 obj")
    					display.remove(event.object2)
    					event.object2= nil
            		end
            	end
            end
        end

    end
    Runtime:addEventListener("collision",onCollision)
	--------------------------------------------
	-- ***GAMELOOP Runtime Listener***
	--Controls the movement of the enemies.
	--------------------------------------------
	function gameLoop()

		if gameIsActive == true then
			local i
			for i = 1,1,-1 do
			--	print "in game loop i"
			--	local enemy = enemyGroup[i]
				if enemy ~= nil and enemy.y ~= nil then
					enemy:translate( enemy.speed, 0)

					--Check to see if the enemy needs to change its direciton.
					enemy.travelled = enemy.x; --enemy.travelled + enemy.speed

					if enemy.travelled >= (display.contentWidth -10) or enemy.travelled <= 10 then
						enemy.speed = -enemy.speed 
						enemy.xScale = -enemy.xScale
						enemy.travelled = 0
					end
				end
			end
		end
	end
	Runtime:addEventListener("enterFrame",gameLoop)

	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	mmimg:addEventListener("touch", mainmenu)
	event.phase ="begin"
	platform1:addEventListener("touch", function()platform1:removeSelf()end)
	platform2:addEventListener("touch", tapRemove)
	platform3:addEventListener("touch", tapRemove)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	print "exiting scene game 2"
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	Runtime:removeEventListener( "touch", platform1 )
	Runtime:removeEventListener( "touch", platform2 )
	Runtime:removeEventListener( "touch", platform3 )
	Runtime:removeEventListener("enterFrame", gameLoop)
	--Stop any loops/listeners from running
	Runtime:removeEventListener( "collision", onCollision )
	Runtime:removeEventListener("enterFrame", gameLoop)

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	Runtime:removeEventListener( "touch", platform1 )
	Runtime:removeEventListener( "touch", platform2 )
	Runtime:removeEventListener( "touch", platform3 )
	Runtime:removeEventListener("enterFrame", gameLoop)
	Runtime:removeEventListener( "collision", onCollision )

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