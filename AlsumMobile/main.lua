-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

local function onFirstView( event )
	composer.gotoScene( "start" )
	bgm = audio.loadStream("content/audio/AsherFulero.mp3")
	audio.play(bgm, {loops=-1})
end

onFirstView()	-- invoke first tab button's onPress event manually
