-----------------------------------------------------------------------------------------
--
-- map4.lua
--
-----------------------------------------------------------------------------------------
--
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage( "content/image/background/map2.png", display.contentWidth, display.contentHeight )
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	--이장집 문--
	local door = display.newRect(display.contentWidth*0.66, display.contentHeight *0.68, 1,10)
	door:setFillColor(0.3)

	--단서 노트--
	local clueNote= display.newImage("content/image/note/note_s.png")
	clueNote.x, clueNote.y = 100,100

	--대화창
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,866
	textBox.alpha = 0
	--이름
	local speaker = display.newText("송은주", textBox.x*0.34, textBox.y*0.85,"content/font/NanumBarunGothic.ttf") 
	speaker.size = 27
	speaker:setFillColor(1)
	speaker.alpha = 0
	--대사
	local txt = display.newText("여기에는 아무 것도 없네", textBox.x,textBox.y*1.03, display.contentWidth*0.7, 150,"content/font/NanumBarunGothic.ttf") 
	txt.width = display.contentWidth*0.6
	txt.size = 35
	txt:setFillColor(0.61, 0.31, 0)
	txt.alpha = 0


	--은주 움직임
	local eunjooSheet = graphics.newImageSheet("content/image/character/eunjoo_walkLR.png", { width = 720 / 4, height = 1200/4, numFrames = 16})
    local sequenceData = {
        {
            name = "right",
            frames = {1,2,3,4,5,6,7,8},
            time = 500,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "left",
            frames = {9,10,11,12,13,14,15,16},
            time = 500,
            loopCount = 0,
            loopDirection = "forward"
        }
    }
	--은주
	local pos = composer.getVariable("goToMap4")
	local eunjoo = display.newSprite(eunjooSheet, sequenceData)
	local eunjoo2 = display.newImage("content/image/character/eunjoo2.png")
	local eunjoo3 = display.newImage("content/image/character/eunjoo.png")

	eunjoo.alpha = 0
	if(composer.getVariable("map4dir")==-1)then
		eunjoo2.alpha = 0
		eunjoo3.alpha = 1
	else
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
	end

	if pos==1 then
		eunjoo.x = door.x
	else
		eunjoo.x = composer.getVariable("goToMap4")
	end
	eunjoo.y = display.contentHeight*0.68
	eunjoo2.x = eunjoo.x
	eunjoo2.y = eunjoo.y
	eunjoo3.x,eunjoo3.y = eunjoo.x, eunjoo.y
 	
--이동
	local function move(event)
		if (event.keyName == "enter" and event.phase=="down") then
			if (eunjoo.x >= door.x-100 and eunjoo.x <=door.x+100) then
				composer.setVariable("gongHome", 0)
				composer.removeScene("map4")
				Runtime:removeEventListener("key",move)
				composer.gotoScene("searchGong")
			end
		end
		--좌우이동
		if (event.phase == "down") then
			--맵 연결
			if(eunjoo.x < 2 and eunjoo2.x < 2) then				
				composer.setVariable("goToMap3",1) 
				Runtime:removeEventListener("key",move)
				composer.removeScene("map4")
				composer.gotoScene("map3")
			end
			if (event.keyName == "right" or event.keyName == "left") then
			   eunjoo.alpha = 1
			   eunjoo2.alpha = 0
			   eunjoo3.alpha = 0
			   if (event.keyName == "right") then
				  eunjoo:setSequence("right")
				  eunjoo:play()
				  composer.setVariable("map4dir",-1)
				  transition.moveBy( eunjoo, { x= display.contentWidth-eunjoo.x, time = (display.contentWidth - eunjoo.x)*2} )
			   elseif (event.keyName == "left") then
					if(eunjoo.x < 2 and eunjoo2.x < 2 ) then
						Runtime:removeEventListener("key",move)
						composer.setVariable("toMap1", 2)
						composer.removeScene("map4")
						composer.gotoScene("map1")
					end
				  eunjoo:setSequence("left")
				  eunjoo:play()
				  composer.setVariable("map4dir",1)
				  if (eunjoo.x >= 2) then
					 transition.moveBy( eunjoo, { x= -eunjoo.x, time = eunjoo.x * 2} )
				  end
			   end
			end
		 --멈춤
		 elseif (event.phase == "up") then
			if(eunjoo.x < 5) then
				Runtime:removeEventListener("key",move)
				composer.setVariable("toMap1", 2)
				composer.removeScene("map4")
				composer.gotoScene("map1")
			end
			if(eunjoo.x > display.contentWidth * 0.987) then
				composer.setVariable("goToMap3", 1)
				Runtime:removeEventListener("key",move)
				composer.removeScene("map4")
				composer.gotoScene("map3")
			end
			transition.cancel(eunjoo)
			eunjoo:pause()
			eunjoo.alpha = 0
			if (event.keyName == "right") then
			   eunjoo3.alpha = 1
			   eunjoo3.x,eunjoo3.y = eunjoo.x, eunjoo.y
			elseif (event.keyName == "left") then
			   eunjoo2.alpha = 1
			   eunjoo2.x,eunjoo2.y = eunjoo.x, eunjoo.y
			end
		 end
	  end
	  Runtime:addEventListener("key",move)
	  --단서노트 버튼
	local function gotoNote(event)
		composer.setVariable("scene",4); 
		composer.setVariable("goToMap4", eunjoo.x)
		composer.removeScene("map4")
		composer.gotoScene("note")

	end
	clueNote:addEventListener("tap",gotoNote)
	
	--레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(door)
	sceneGroup:insert(clueNote)
	sceneGroup:insert(speaker)
	sceneGroup:insert(eunjoo)
	sceneGroup:insert(eunjoo2)
	sceneGroup:insert(eunjoo3)
	sceneGroup:insert(textBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(txt)
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
