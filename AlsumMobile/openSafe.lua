-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	--밑판
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	--배경
	local bg = display.newImage("content/image/Gong/openSafeBackground.png");
	bg.x, bg.y = display.contentCenterX, display.contentCenterY
	--돌아가는 부분
	local circle = display.newImage("content/image/Gong/dial.png", display.contentWidth/2, display.contentHeight*0.58)
	--리셋버튼
	local reset = display.newImage("content/image/Gong/resetB.png", display.contentWidth*0.5, display.contentHeight*0.9)
	reset.alpha = 0
	--왼쪽 버튼
	local rotateL = display.newImage("content/image/Gong/rotateL.png", display.contentWidth*0.3, display.contentHeight*0.6)
	--오른쪽 버튼
	local rotateR = display.newImage("content/image/Gong/rotateR.png", display.contentWidth*0.7, display.contentHeight*0.6)
	--텍스트 뒤쪽 배경
	local textBox = display.newImage("content/image/Gong/rotateTextBox.png")
	textBox.x,textBox.y = display.contentWidth/2, display.contentHeight*0.25
	--위쪽에 텍스트
	local newTextParams = { text = "오른쪽으로 몇 번 왼쪽으로 몇 번 돌리시겠습니까?", 
						x = display.contentWidth/2,
						y = display.contentHeight*0.25,
						font = "content/font/NanumBarunGothic.ttf", fontSize = 50, 
						align = "center" }
	local text = display.newText( newTextParams )
	text:setFillColor(0.61, 0.31, 0)
	--문고리 돌려서 열기
	local btn = display.newRect(display.contentWidth * 0.15, display.contentHeight * 0.62 , 600, 100)
	btn.alpha = 0
	--문고리 클릭 유도
	local clickHere = display.newImageRect("content/image/Gong/clickHere.png", 100, 100)
	clickHere.x, clickHere.y = display.contentWidth * 0.15, display.contentHeight * 0.44
	clickHere.alpha = 0
	--나가기
	local goOut = display.newImage("content/image/clue/diary_exitB.png")
	goOut.x, goOut.y = display.contentWidth * 0.92, display.contentHeight * 0.09
	--비번 맞출 때 끼릭끼릭
	local sound = audio.loadSound("content/audio/lock.wav")
	
	--먼저 누른 버튼
	local start = 0
	--돌아간 각도
	local theta = 0
	--정답 : 먼저 왼쪽으로 두번 돌린 뒤 오른쪽으로 다섯번 돌리기
	--왼쪽으로 돌린 횟수
	local cnt = 0
	--오른쪽으로 돌린 횟수
	local cnt2 = 0
	--삼각형 띠용띠용
	local function moving(obj)
		clickHere.alpha = 1
		clickHere.y = display.contentHeight * 0.44
		transition.to( clickHere, { time=700, alpha=0.5, y=display.contentHeight * 0.5, onComplete=moving } )
	end
	--왼쪽으로 돌아감
	local function clickLeft(event)
		audio.play(sound)
		reset.alpha = 1
		theta = theta - 36
		if (start == 2 or cnt2 > 0) then
			cnt = 0
		else
			cnt = cnt+1
		end
		transition.to( circle, { rotation=-36, time=200, delta=true} )
	end
	rotateL:addEventListener("tap", clickLeft)
	--오른쪽으로 돌아감
	local function clickRight(event)
		audio.play(sound)
		reset.alpha = 1
		theta = theta + 36
		start = 2
		if(cnt == 2) then
			cnt2 = cnt2 + 1
		end
		transition.to( circle, { rotation=36, time=200, delta=true} )

		if (cnt == 2 and cnt2 == 5) then
			btn.alpha = 0.02
			reset.alpha = 0
			rotateL.alpha = 0
			rotateR.alpha = 0
			clickHere.alpha = 1
			goOut.alpha = 0
			text.text = "열렸습니다."
			transition.to( clickHere, { time=700, alpha=0.5, y=display.contentHeight * 0.5, onComplete=moving } )
		end
	end
	rotateR:addEventListener("tap", clickRight)
	--리셋버튼
	local function clickReset(event)
		audio.play(sound)
		start = 0
		cnt = 0
		cnt2 = 0
		transition.to( circle, { rotation=-theta, time=100, delta=true} )
		theta = 0
	end
	reset:addEventListener("tap", clickReset)

	local function open(event)
		composer.setVariable("clue8",1)
		composer.removeScene("openSafe")
		composer.gotoScene("gongBookshelf")
	end
	btn:addEventListener("tap",open)

	local function clickOut(event)
		composer.removeScene("openSafe")
		composer.setVariable("fail", 1)
		composer.gotoScene("gongBookshelf")
	end
	goOut:addEventListener("tap",clickOut)

	sceneGroup:insert(background)
	sceneGroup:insert(bg)
	sceneGroup:insert(textBox)
	sceneGroup:insert(circle)
	sceneGroup:insert(reset)
	sceneGroup:insert(rotateL)
	sceneGroup:insert(rotateR)
	sceneGroup:insert(text)
	sceneGroup:insert(goOut)
	sceneGroup:insert(clickHere)
	sceneGroup:insert(btn)
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