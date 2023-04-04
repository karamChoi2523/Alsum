-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
		local sceneGroup = self.view
		local bed =display.newGroup()
		local foundItem=display.newGroup()
		local found2
		
		--아이템 나올 때 배경
		local black = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
		black:setFillColor(0)
		black.alpha = 0
		
		--배경
		local background = display.newImage(bed,"content/image/gayeong/bed.png")
		background.x, background.y = display.contentWidth / 2,display.contentHeight / 2
		--이불
		local blanket1 = display.newImage(bed,"content/image/gayeong/blanket1.png")
		blanket1.x, blanket1.y = display.contentWidth * 0.647,display.contentHeight *0.6
		blanket1.alpha = 1
		local blanket2 = display.newImage(bed,"content/image/gayeong/blanket2.png")
		blanket2.x, blanket2.y = display.contentWidth * 0.647,display.contentHeight *0.6
		blanket2.alpha = 0
		--이불 위 폰
		local phone = display.newImage(bed,"content/image/gayeong/phone.png")
		phone.x, phone.y = display.contentWidth * 0.65, display.contentHeight * 0.65
		phone.alpha = 0
		--아이템
		local phoneClue = display.newImage(foundItem,"content/image/clue/phone.png")
		phoneClue.x, phoneClue.y = display.contentWidth /2, display.contentHeight *0.4
		--텍스트상자
		local textBox = display.newImage(foundItem,"content/image/narration/textbox.png")
		textBox.x, textBox.y = display.contentWidth/2, display.contentHeight*0.82
		--이름
		local speaker = display.newText(foundItem,"핸드폰", textBox.x*0.34, textBox.y*0.85,"content/font/NanumBarunGothic.ttf")  
		speaker.size = 27
		speaker:setFillColor(1)
		--다음버튼 
		local nextB = display.newImage(foundItem,"content/image/narration/nextB.png")
		nextB.x, nextB.y = display.contentWidth * 0.85, display.contentHeight *0.89
		nextB.alpha = 0

		--나가기 버튼
		local exitB = display.newImage("content/image/clue/diary_exitB.png")
		exitB.x, exitB.y = display.contentWidth * 0.92, display.contentHeight * 0.09
		--exitB.alpha = 1
		--대사
		local script = display.newText(foundItem,"핸드폰을 발견했다.", textBox.x,textBox.y*1.03, display.contentWidth*0.75, 150,"content/font/NanumBarunGothic.ttf") 
		script.width = display.contentWidth*0.6
		script.size = 35
		script.align = "left"
		script:setFillColor(0.61, 0.31, 0)
		foundItem.alpha = 0
		
		if(found2 == 1)then
			exitB.alpha = 1
		else
			exitB.alpha = 0
		end

		--이불 들추기
		exitB.alpha = 0
		local function tapBlanket1(event)
			blanket1.alpha = 0
			blanket2.alpha = 1
			if(found2 == 1)then 
				phone.alpha = 0
				exitB.alpha = 1
			else
			  phone.alpha = 1
			  exitB.alpha = 0
			end
		end
		local function tapBlanket2(event)
			blanket1.alpha = 1
			blanket2.alpha = 0
			phone.alpha = 0
		end

		local function foundPhone(event)
			--휴대폰
			found2 = 1
			nextB.alpha = 1
			foundItem.alpha = 1
			black.alpha = 0.2
		end

		local function backToHome()
			bed.alpha = 1
			foundItem.alpha = 0
			nextB.alpha = 0
			black.alpha = 0
			exitB.alpha = 1
			phone.alpha = 0
			composer.setVariable("clue5", 1)
			composer.setVariable("bedLoc", 1)
			composer.setVariable("deskLoc", 0)
			composer.setVariable("noteLoc", 0) 
			composer.gotoScene("gayeongHome")
		end
		local function readMsg()
			phone.alpha = 0
			bed.alpha = 1
			black.alpha = 0
			foundItem.alpha = 0
			nextB.alpha = 0
			background.alpha = 1
			composer.gotoScene("readMsg")
			
		end 
		--returnB:addEventListener("tap", backToHome)

		blanket1:addEventListener("tap", tapBlanket1)
		blanket2:addEventListener("tap", tapBlanket2)
		phone:addEventListener("tap", foundPhone)
		nextB:addEventListener("tap", readMsg)
		exitB:addEventListener("tap", backToHome)
		sceneGroup:insert(background)
		sceneGroup:insert(bed)
		sceneGroup:insert(black)
		sceneGroup:insert(foundItem)
		sceneGroup:insert(nextB)
		nextB:toFront()
		sceneGroup:insert(exitB)
		exitB:toFront()
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