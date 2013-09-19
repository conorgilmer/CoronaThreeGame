-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"

-- load sceneMenu.lua
storyboard.gotoScene( "sceneMenu" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):


--Create a constantly looping background sound...
local bgSound = audio.loadStream("bgSound.mp3")
audio.reserveChannels(1)   --Reserve its channel
audio.play(bgSound, {channel=1, loops=-1}) --Start looping the sound.
