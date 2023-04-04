-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
		local sceneGroup = self.view
		local msgG = display.newGroup()

		local background = display.newImage("content/image/gayeong/phone_L.png")
		background.x, background.y = display.contentWidth / 2, display.contentHeight /2
		local msgGroup = display.newImage("content/image/gayeong/messageGroup.png")
		msgGroup.x, msgGroup.y = display.contentWidth / 2, display.contentHeight * 0.4
		local gongMsg = display.newImage(msgG,"content/image/gayeong/message_Gong.png")
		gongMsg.x, gongMsg.y = display.contentWidth / 2, display.contentHeight * 0.4
		local joMsg = display.newImage(msgG,"content/image/gayeong/message_Jo.png")
		joMsg.x, joMsg.y = display.contentWidth / 2, display.contentHeight /2
		local hanMsg = display.newImage(msgG ,"content/image/gayeong/message_Han.png")
		hanMsg.x, hanMsg.y = display.contentWidth / 2, display.contentHeight *0.6
		msgG.alpha = 0
		local exitB = display.newImage("content/image/clue/diary_exitB.png")
		exitB.x, exitB.y = display.contentWidth * 0.92, display.contentHeight * 0.09
		exitB.alpha = 0
			--텍스트상자
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,display.contentHeight*0.82
	textBox.alpha  = 0
	--단서노트버튼
	--local button = display.newImage("content/image/note/note_s.png")
	--button.x = 100
	--button.y = 100
	--이름
	local speaker = display.newText("핸드폰", textBox.x*0.34, textBox.y*0.85,"content/font/NanumBarunGothic.ttf") 
	speaker.size = 27
	speaker:setFillColor(1)
	speaker.alpha = 0
	--대사
	local script = display.newText("이장, 한상혁, 조애경한테 문자가 와있다",textBox.x,textBox.y*1.03, display.contentWidth*0.75, 150,"content/font/NanumBarunGothic.ttf") 
    --script.width = display.contentWidth * 0.6 
    script.size = 35
	script.align="left"
    script:setFillColor(0.61, 0.31, 0)
	script.alpha = 0
	
		local function checkList()
			msgGroup.alpha = 0
			msgG.alpha = 1
			textBox.alpha  = 1
			speaker.alpha = 1
			script.alpha = 1
			exitB.alpha = 1
		end
		local function backToHome()
			textBox.alpha  = 1
			speaker.alpha = 1
			script.alpha = 1
			composer.setVariable("bedLoc", 1)
			composer.setVariable("deskLoc", 0)
			composer.setVariable("noteLoc", 0) 
			composer.setVariable("clue5", 1)
			composer.removeScene("readMsg")
			composer.gotoScene("gayeongHome")
		end
		msgGroup:addEventListener("tap", checkList)
		exitB:addEventListener("tap", backToHome)

		sceneGroup:insert(background)
		sceneGroup:insert(msgG)
		sceneGroup:insert(msgGroup)
		sceneGroup:insert(exitB)
		sceneGroup:insert(textBox)
		sceneGroup:insert(speaker)
		sceneGroup:insert(script)
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
		composer.removeScene("searchGong")
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