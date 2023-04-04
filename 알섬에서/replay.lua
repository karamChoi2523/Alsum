-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
require("ending")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage("content/image/ending/theEnd.png")
	background:setFillColor(1)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2


	--credit
	local options1 = 
	{
    	text = "개발 \n\n\n\n디자인 \n\nSOUND",
    	x = 1200,
    	y = 500,
    	width = 500,
    	align = "center",
    	font = "content/font/나눔손글씨+성실체.ttf",
    	fontSize = 70
	}
	local myText1 = display.newText( options1 )
	myText1:setFillColor( 0, 0, 0 )

	local options2 = 
	{
    	text = "강승연\n김유진\n나현주\n신이현\n최가람 \n\n\n이지수 \n\n\n\nSurrendoer - Asher Fulero",
    	x = 1200,
    	y = 575,
    	width = 500,
    	align = "center",
    	font = "content/font/나눔손글씨+성실체.ttf",
    	fontSize = 40
	}
	local myText2 = display.newText( options2 )
	myText2:setFillColor( 0, 0, 0 )


	--
	local theend = display.newImage("content/image/ending/theEndText.png")
	theend.x, theend.y = display.contentCenterX*1.3, display.contentCenterY*1.0
	theend.alpha = 0

	--다시 시작--
	--local replay = display.newImage("content/image/ending/replayB.png", display.contentCenterX*1.65, display.contentCenterY*1.3)
	--replay.alpha = 0


	local limit = 5

	local function timeAttack( event )
		limit = limit - 1

		if limit==0 then
			options1.alpha = 0
			myText1.alpha = 0
			myText2.alpha = 0
			options2.alpha = 0
			theend.alpha = 1
			--replay.alpha = 1
		end
	end

	timer.performWithDelay (1000, timeAttack, 0)



	--[[local function reload(event)
		if(event.phase == "began") then
			sceneGroup:insert(background)
			sceneGroup:insert(theend)
			sceneGroup:insert(replay)
			composer.removeScene("replay")
			composer.gotoScene("start")
		end
	end]]
	--replay:addEventListener("touch", reload)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
