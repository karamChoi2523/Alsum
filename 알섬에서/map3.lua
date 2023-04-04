-----------------------------------------------------------------------------------------
--
--map3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(1)
	--진짜 배경
	local bg = display.newImage("content/image/background/map3.png")
	bg.x, bg.y = display.contentCenterX, display.contentCenterY
	--note
	local note = display.newImage("content/image/note/note_s.png")
	note.x = 100
	note.y = 100
	--가영 집
	local house = display.newRect(display.contentWidth*0.71, display.contentHeight*0.58, display.contentWidth*0.1, display.contentHeight*0.25)
	house.alpha = 0.01
	--다온
	local daon = display.newImage("content/image/character/daon.png")
	daon.x, daon.y = display.contentWidth*0.3, display.contentHeight*0.68
	--엔터
	local enterB = display.newImage("content/image/character/enter.png")
	enterB.x, enterB.y = display.contentWidth*0.3, display.contentHeight*0.58
	enterB.alpha = 0

	--대사
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,display.contentHeight*0.82
	textBox.alpha = 0

	local textParams = { text = "송은주", 
						x =  textBox.x*0.34, 
						y = textBox.y*0.85,
						font = "content/font/NanumBarunGothic.ttf", 
						fontSize = 27, 
						align = "center" }
	local speaker = display.newText(textParams)
	speaker:setFillColor(1)
	speaker.alpha = 0

	local txt = display.newText("더미", textBox.x,textBox.y*1.03, display.contentWidth*0.7, 150,"content/font/NanumBarunGothic.ttf") 
	txt.width = display.contentWidth*0.75
	txt.height = 150
	txt.size = 35
	txt:setFillColor(0.61, 0.31, 0)
	txt.alpha = 0


	--집에서 나왔음(3) map2에서 건너옴(1) 아이랑 대화 끝남(2)
	local position = composer.getVariable("goToMap3")
	--은주
	local eunjooSheet = graphics.newImageSheet("content/image/character/eunjoo_walkLR.png", { width = 720 / 4, height = 600/2, numFrames = 16})
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
	local eunjoo = display.newSprite(eunjooSheet, sequenceData)
	local eunjoo2 = display.newImage("content/image/character/eunjoo.png")
	local eunjoo3 = display.newImage("content/image/character/eunjoo2.png")
	eunjoo.alpha = 0

	if((composer.getVariable("map3Dir")==-1)and composer.getVariable("goToMap3")==1)then
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
	elseif(composer.getVariable("map3Dir")==-1)then
		eunjoo2.alpha = 0
		eunjoo3.alpha = 1
	else
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
	end

	if position==1 then
		eunjoo.x = display.contentWidth*0.03
		composer.setVariable("map3Dir", 1)
	elseif position==2 then
		eunjoo.x = daon.x
	elseif position==3 then
		eunjoo.x = house.x
	else
		eunjoo.x = composer.getVariable("goToMap3")
	end
	eunjoo.y = display.contentHeight*0.68
	eunjoo2.x,eunjoo2.y = eunjoo.x, eunjoo.y
	eunjoo3.x,eunjoo3.y = eunjoo.x, eunjoo.y

	local function move(event)
		--다온이 근처에서 엔터 나타남
	
			if (eunjoo.x >= daon.x-100 and eunjoo.x <= daon.x+100) then
				enterB.alpha = 0.8
			else
				enterB.alpha = 0
			end

		--상호작용
		if (event.keyName == "enter" and event.phase == "down") then
			--집에 들어가기
			if (eunjoo.x >= house.x-100 and eunjoo.x <=house.x+100) then
				if (composer.getVariable("clue2") == 1) then
					composer.setVariable("map3Dir", -1)
					composer.removeScene("map3")
					Runtime:removeEventListener("key",move)
					composer.gotoScene("gayeongHome")
				else
					textBox.alpha = 1;
					speaker.alpha = 1;
					speaker.text = "송은주"
					txt.alpha = 1;
					txt.text = "아직 들어갈 수 없어.";
				end
			end	
		end		

			--다온 대화
		if ( event.keyName == "enter" ) then	
			if (eunjoo.x >= daon.x-75 and eunjoo.x <=daon.x+75) then
				if (composer.gotoScene("talkkid") == 1 ) then	
					composer.removeScene("map3")
					Runtime:removeEventListener("key",move)
					composer.gotoScene("talkkid")
					
				end
			end
		end
		if (eunjoo.x < 0) then
			--맵연결을 위한 변수 
			composer.setVariable("map2,3", 1) 
			composer.setVariable("map1,2", 0)
			composer.setVariable("map2dir", -1)
			Runtime:removeEventListener("key",move)
			composer.removeScene("map3")
			composer.gotoScene("map2")
		end
		--좌우이동
		if (event.phase == "down") then
			if (event.keyName == "right" or event.keyName == "left") then
				eunjoo.alpha = 1
				eunjoo2.alpha = 0
				eunjoo3.alpha = 0
				textBox.alpha = 0;
				speaker.alpha = 0;
				txt.alpha = 0;

				if (event.keyName == "right") then
					eunjoo:setSequence("right")
					eunjoo:play()
					composer.setVariable("map3Dir", 1)
					transition.moveBy( eunjoo, { x= display.contentWidth-eunjoo.x, time = (display.contentWidth - eunjoo.x)*2} )
				elseif (event.keyName == "left") then
					eunjoo:setSequence("left")
					eunjoo:play()
					composer.setVariable("map3Dir", -1)
					if (eunjoo.x >= 0) then
						transition.moveBy( eunjoo, { x= -eunjoo.x-50, time = eunjoo.x * 2} )
					end
				end
			end
		elseif (event.phase == "up") then
			transition.cancel(eunjoo)
			eunjoo:pause()
			eunjoo.alpha = 0
			
			if (event.keyName == "right") then
				eunjoo2.alpha = 1
				eunjoo2.x,eunjoo2.y = eunjoo.x, eunjoo.y
			elseif (event.keyName == "left") then
				eunjoo3.alpha = 1
				eunjoo3.x,eunjoo3.y = eunjoo.x, eunjoo.y
			end
		end
	end
	Runtime:addEventListener("key",move)

	--단서노트 버튼
	local function gotoNote(event)
		composer.setVariable("scene",3); 
		composer.setVariable("goToMap3", eunjoo.x)
		composer.removeScene("map3")
		composer.gotoScene("note")
	end
	note:addEventListener("tap",gotoNote)

	sceneGroup:insert(background)
	sceneGroup:insert(bg)
	sceneGroup:insert(house)
	sceneGroup:insert(eunjoo)
	sceneGroup:insert(eunjoo2)
	sceneGroup:insert(eunjoo3)
	sceneGroup:insert(daon)
	sceneGroup:insert(enterB)
	sceneGroup:insert(textBox)
	sceneGroup:insert(txt)
	sceneGroup:insert(speaker)
	sceneGroup:insert(note)
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
