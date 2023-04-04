-----------------------------------------------------------------------------------------
--
-- 마을회관.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	--map1배경
	local background = display.newImage("content/image/background/village.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY
	--단서노트
	local note = display.newImage("content/image/note/note_s.png")
	note.x = 100
	note.y = 100
	--마을회관입장문
	local villageHall = display.newRect(display.contentWidth*0.8, display.contentHeight*0.55, display.contentWidth*0.1, display.contentHeight*0.15)
    villageHall:setFillColor(1, 0, 0, 0.01)
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
	local txt = display.newText("여기에는 아무 것도 없네", textBox.x,textBox.y*1.03, display.contentWidth*0.75, 150,"content/font/NanumBarunGothic.ttf") 
	txt.width = display.contentWidth*0.6
	txt.size = 35
	txt.align="left"
	txt:setFillColor(0.61, 0.31, 0)
	txt.alpha = 0
	--돌아가기
	local goBack = display.newImage("content/image/narration/returnB.png")
	goBack.x, goBack.y = display.contentWidth * 0.85, display.contentHeight * 0.89
	goBack.alpha = 0
	--이동 버튼
	local leftB = display.newImage("content/image/button/leftB.png")
	leftB.x, leftB.y = display.contentWidth*0.7,display.contentHeight*0.9
	leftB.alpha = 0.7
	local rightB = display.newImage("content/image/button/rightB.png")
	rightB.x, rightB.y = display.contentWidth*0.8,display.contentHeight*0.9
	rightB.alpha = 0.7
	local enterB = display.newImage("content/image/button/enterB.png")
	enterB.x, enterB.y = display.contentWidth-(display.contentHeight*0.1),display.contentHeight*0.9
	enterB.alpha = 0.7


	local eunjooSheet = graphics.newImageSheet("content/image/character/eunjoo_walkLR.png", 
	{ width = 720 / 4, height = 600/2, numFrames = 16})

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
	--은주 위치
	toMap_1 = composer.getVariable("toMap1")
	local noteToMap_1 = composer.getVariable("noteToMap1")
	--suspectEunjooToMap1, guessingToMap1는 문 앞에 위치
	if (toMap_1 == 1) or (toMap_1 == 4)then
		eunjoo.x = villageHall.x
		eunjoo.y = display.contentHeight*0.68
		composer.setVariable("map1Dir",1)
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
		eunjoo.alpha = 0
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
	--map2ToMap1
	elseif (toMap_1 == 2) then
		eunjoo.x = display.contentWidth*0.98
		eunjoo.y = display.contentHeight*0.68
		composer.setVariable("map1Dir",-1)
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo.alpha = 0
		eunjoo2.alpha = 0
		eunjoo3.alpha = 1
	--prologueToMap1
	elseif (toMap_1 == 5) then
		eunjoo.alpha = 0
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
		eunjoo.x = display.contentWidth*0.03
		eunjoo.y = display.contentHeight*0.68
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
	--NoteToMap1
	else 
		eunjoo.alpha = 0
		eunjoo.x = toMap_1
		eunjoo.y = display.contentHeight*0.68
		if(composer.getVariable("map1Dir") == 1)then
			eunjoo2.alpha = 1
			eunjoo3.alpha = 0
		elseif(composer.getVariable("map1Dir") == -1)then
			eunjoo2.alpha = 0
			eunjoo3.alpha = 1
		else
			eunjoo2.alpha = 1
			eunjoo3.alpha = 0
		end
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
	end

	--엔터 
	local function tapEnter(event)
		if(event.phase=="began" or event.phase=="moved")then
			enterB.alpha= 1
		else
			enterB.alpha =0.7
		end
		if (event.target == enterB) then
			if (eunjoo.x >= villageHall.x-100 and eunjoo.x <=villageHall.x+100) then
				leftB.alpha = 0
				rightB.alpha = 0
				enterB.alpha = 0
				--아이 만난 후
				if(composer.getVariable("clue1")==1 and composer.getVariable("clue2")~=1)then
					composer.removeScene("map1")
					composer.gotoScene("dead")
					print("시신을 확인하러 가는 은주")
				--prologue에서 party로 들어갈때
				elseif (composer.getVariable("goToParty")==1)then
					composer.removeScene("map1")
					composer.gotoScene("party")
					print("이장의 생일파티에 참석하게 된 은주")
				--아이 진술 전 막기
				elseif (composer.getVariable("clue1") ~= 1) then
					textBox.alpha =1
					speaker.alpha = 1
					txt.text="빨리 도망가자."
					txt.alpha = 1
					goBack.alpha = 1
				elseif (composer.getVariable("clue2") == 1 and composer.getVariable("clue6")~=1) then
					textBox.alpha =1
					speaker.alpha = 1
					txt.text="가영 씨의 집으로 가자."
					txt.alpha = 1
					goBack.alpha = 1
				end
				if (composer.getVariable("clue8") == 1) then
					composer.removeScene("map1")
					composer.gotoScene("ending")
					print("게임 종료창으로 들어갑니다.")
				end
			end
		end
	end
	enterB:addEventListener("touch", tapEnter)
	--좌우이동
	local function moving(event)
		rightB.alpha = 0.7
		leftB.alpha = 0.7
		enterB.alpha = 0.7
		if(eunjoo.x > display.contentWidth*0.987) then
			if (composer.getVariable("permitMap2") == 1) then
				composer.setVariable("map2,3", 0) 
				composer.setVariable("map1,2", 1)
				leftB.alpha = 0
				rightB.alpha = 0
				enterB.alpha = 0
				composer.removeScene("map1")
				composer.gotoScene("map2")
			end
		end
		if(event.phase=="began" or event.phase=="moved")then
			textBox.alpha =0
			speaker.alpha = 0
			txt.alpha = 0
			if (event.target == rightB or event.target == leftB) then
				eunjoo.alpha = 1
				eunjoo2.alpha = 0
				eunjoo3.alpha = 0
				if (event.target == rightB) then
					rightB.alpha = 1
					eunjoo:setSequence("right")
					eunjoo:play()
					composer.setVariable("map1Dir", 1)
					transition.moveBy( eunjoo, { x= display.contentWidth-eunjoo.x, time = (display.contentWidth - eunjoo.x)*2} )
				elseif (event.target == leftB) then
					leftB.alpha = 1
					eunjoo:setSequence("left")
					eunjoo:play()
					composer.setVariable("map1Dir", -1)
					--은주이동범위지정
					if (eunjoo.x >= 0) then
						transition.moveBy( eunjoo, { x= -eunjoo.x, time = eunjoo.x * 2} )
					end
				end
			end
		else
			transition.cancel(eunjoo)
			eunjoo:pause()
			eunjoo.alpha = 0
			if (event.target == rightB) then
				eunjoo2.alpha = 1
				eunjoo2.x,eunjoo2.y = eunjoo.x, eunjoo.y
			elseif (event.target == leftB) then
				eunjoo3.alpha = 1
				eunjoo3.x,eunjoo3.y = eunjoo.x, eunjoo.y
			end
		end
	end
	rightB:addEventListener("touch", moving)
	leftB:addEventListener("touch", moving)
	--Runtime:addEventListener("key",move)

	local function closeTextbox(event)
		textBox.alpha = 0
		speaker.alpha = 0
		txt.alpha = 0
		goBack.alpha = 0
		leftB.alpha = 0.7
		rightB.alpha = 0.7
		enterB.alpha = 0.7
	end
	goBack:addEventListener("tap", closeTextbox)

	--단서노트 버튼
	local function gotoNote(event)
		rightB.alpha = 0
		leftB.alpha = 0
		enterB.alpha = 0
		composer.setVariable("scene",1)
		composer.setVariable("toMap1", eunjoo.x)
		composer.removeScene("map1")
		composer.gotoScene("note")
	end
	note:addEventListener("tap",gotoNote)

	sceneGroup:insert(background)
	sceneGroup:insert(villageHall)
	sceneGroup:insert(eunjoo)
	sceneGroup:insert(eunjoo2)
	sceneGroup:insert(eunjoo3)
	sceneGroup:insert(note)
	sceneGroup:insert(leftB)
	sceneGroup:insert(rightB)
	sceneGroup:insert(enterB)
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