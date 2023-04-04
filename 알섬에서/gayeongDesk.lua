-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------
--
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local foundItem =display.newGroup()
	local eunjooX = composer.getVariable("eunjooX")
	local eunjooY = composer.getVariable("eunjooY")
	--아이템 나올 때 배경
	local black = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	black:setFillColor(0)
	black.alpha = 0
	
	--배경
	local background = display.newImage("content/image/gayeong/desk.png")
	background.x, background.y = display.contentWidth /2, display.contentHeight /2
	--다이어리 아이템
	local diaryItem = display.newImage(foundItem,"content/image/clue/diary.png")
	diaryItem.x, diaryItem.y = display.contentWidth /2, display.contentHeight *0.4
	--다이어리 다음버튼 
	local diaryNextB = display.newImage("content/image/narration/nextB.png")
	diaryNextB.x, diaryNextB.y = display.contentWidth * 0.85, display.contentHeight *0.89
	diaryNextB.alpha = 0
	--물건 다음 버튼
	local returnB = display.newImage("content/image/narration/returnB.png")
	returnB.x, returnB.y = display.contentWidth * 0.85, display.contentHeight *0.89
	returnB.alpha = 0

	--다이어리
	local diary = display.newImage("content/image/gayeong/diary.png")
	diary.x, diary.y = display.contentWidth * 0.09, display.contentHeight * 0.64
	--책
	local book = display.newImage("content/image/gayeong/book.png")
	book.x, book.y = display.contentWidth * 0.91, display.contentHeight * 0.65
	--필통
	local pencilC = display.newImage("content/image/gayeong/pencilcase.png")
	pencilC.x, pencilC.y = display.contentWidth * 0.3, display.contentHeight * 0.49
	--영수증
	local receipt = display.newImage("content/image/gayeong/receipt.png")
	receipt.x, receipt.y = display.contentWidth * 0.18, display.contentHeight *0.78
	--나가기 버튼
	local exitB = display.newImage("content/image/clue/diary_exitB.png")
	exitB.x, exitB.y = display.contentWidth * 0.92, display.contentHeight * 0.09
	--텍스트상자
	local textBox = display.newImage(foundItem,"content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,display.contentHeight*0.82
	textBox.alpha  = 0
	--단서노트버튼
	--local button = display.newImage("content/image/note/note_s.png")
	--button.x = 100
	--button.y = 100
	--이름
	local speaker = display.newText(foundItem,"송은주", textBox.x*0.34, textBox.y*0.85,"content/font/NanumBarunGothic.ttf")  
	speaker.size = 27
	speaker:setFillColor(1)
	speaker.alpha = 0
	--대사
	local script = display.newText(foundItem,"",textBox.x,textBox.y*1.03, display.contentWidth*0.75, 150,"content/font/NanumBarunGothic.ttf") 
    script.width = display.contentWidth * 0.6 
    script.size = 35
	script.align = "left"
    script:setFillColor(0.61, 0.31, 0)

	foundItem.alpha = 0
	textBox.alpha = 0
	script.alpha = 0
	if(found == 1)then
		diary.alpha = 0
		exitB.alpha = 1
	else
		diary.alpha = 1
		exitB.alpha = 0
	end

    local function foundBook()
		speaker.text = "책"
		script.alpha = 1
		script.text ="책이 있다."
		textBox.alpha = 1
		speaker.alpha = 1
		diaryNextB.alpha = 0
		returnB.alpha = 1
		diaryItem.alpha = 0
		black.alpha = 0.2
	end
	book:addEventListener("tap", foundBook)

	local function foundPencilC()
		speaker.text = "필통"
		script.alpha = 1
		textBox.alpha = 1
		speaker.alpha = 1
		script.text ="필통이 있다."
		diaryNextB.alpha = 0
		returnB.alpha = 1
		black.alpha = 0.2
		diaryItem.alpha = 0
	end
	pencilC:addEventListener("tap", foundPencilC)

	local function foundRecipt()
		speaker.text = "영수증"
		script.alpha = 1
		textBox.alpha = 1
		speaker.alpha = 1
		script.text ="영수증이 있다."
		diaryNextB.alpha = 0
		returnB.alpha = 1
		black.alpha = 0.2
		diaryItem.alpha = 0
	end
	receipt:addEventListener("tap", foundRecipt)
    local function foundDiary()
		speaker.alpha = 1
		speaker.text = "다이어리"
		script.alpha = 1
		script.text = "다이어리를 발견했다"
		textBox.alpha = 1
		foundItem.alpha = 1
		black.alpha = 0.2
		diaryNextB.alpha = 1
		diaryItem.alpha = 1
		returnB.alpha = 0
    end
	
	--단서노트 버튼
	--[[local function gotoNote(event)
		composer.gotoScene("~~~")
	print("gotoNote")
	end]]
	--button2:addEventListener("tap",gotoNote)
   diary:addEventListener("tap", foundDiary)

	local function backToHome()
		textBox.alpha = 0
		foundItem.alpha = 0
		background.alpha = 1
		black.alpha = 0
		speaker.alpha = 0
		diary.alpha = 1
		pencilC.alpha = 1
		book.alpha = 1
		exitB.alpha = 1
		receipt.alpha = 1
		returnB.alpha = 0
		diaryNextB.alpha = 0
		if(found == 1)then
			diary.alpha = 0
		else
			diary.alpha = 1
		end
		--textBox.alpha = 0
		--script.alpha = 0
		--speaker.alpha = 0
		returnB.alpha = 0
		composer.setVariable("clue6", 1)
		composer.setVariable("bedLoc", 0)
		composer.setVariable("deskLoc", 1)
		composer.setVariable("noteLoc", 0) 
		composer.gotoScene("gayeongHome")
	end
	exitB:addEventListener("tap",backToHome)

	local function readDiary(event)
		speaker.alpha = 0
		foundItem.alpha = 0
		background.alpha = 1
		black.alpha = 0
		diary.alpha = 1
		pencilC.alpha = 1
		book.alpha = 1
		exitB.alpha = 1
		script.alpha = 0
		textBox.alpha = 0
		diary.alpha = 0
		diaryNextB.alpha = 0
		returnB.alpha = 0
		found = 1
		composer.removeScene("gayeongDesk")
		composer.gotoScene("readDiary")
	end

	--다음버튼 누르면 아이템
	diaryNextB:addEventListener("tap", readDiary)

	local function backToDesk(event)
		script.alpha = 0
		textBox.alpha = 0
		speaker.alpha = 0
		diaryNextB.alpha = 0
		returnB.alpha = 0
		black.alpha = 0
	end
	--물건 눌렀을 때 돌아가기
	returnB:addEventListener("tap", backToDesk)
	--레이어정리
	sceneGroup:insert(background)
    sceneGroup:insert(diary)
	sceneGroup:insert(book)
	sceneGroup:insert(receipt)
	sceneGroup:insert(black)
	sceneGroup:insert(pencilC)
	sceneGroup:insert(black)
	--sceneGroup:insert(deskG)
	--sceneGroup:insert(button)
	sceneGroup:insert(textBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(script)
	sceneGroup:insert(foundItem)
	sceneGroup:insert(exitB )
	sceneGroup:insert(diaryNextB)
	sceneGroup:insert(returnB)
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
