-----------------------------------------------------------------------------------------
--
-- dead.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(1)

	local body = display.newImage("content/image/dead/dead.png", display.contentWidth/2, display.contentHeight/2 )

    local stomach = display.newCircle(body.x + 265, body.y + 340, 100)
	stomach:setFillColor(1, 1, 0, 0.2)

    local face = display.newCircle(body.x - 75, body.y - 160, 50)
	face:setFillColor(1, 1, 0, 0.2)

	local head = display.newCircle(body.x - 170, body.y - 300, 50)
	head:setFillColor(1, 1, 0, 0.2)
	--textBox
	local scriptBack = display.newImage("content/image/narration/textbox.png", display.contentWidth/2, display.contentHeight*0.82)
	scriptBack.alpha = 0
	--신체부위
	local bodyName = display.newText("", scriptBack.x*0.34, scriptBack.y*0.85,"content/font/NanumBarunGothic.ttf")
	bodyName.size = 27
	bodyName.alpha = 0
	bodyName:setFillColor(1)
	--다음버튼
    local endButton = display.newImage("content/image/narration/nextB.png")
    endButton.x, endButton.y = display.contentWidth*0.85, display.contentHeight*0.89
	endButton.alpha = 0
	--나가기버튼
	local outButton = display.newImage("content/image/clue/diary_exitB.png")
    outButton.x, outButton.y = display.contentWidth*0.92, display.contentHeight*0.09
	outButton.alpha = 0
	--대사
    local script = display.newText("더미 텍스트입니다.", scriptBack.x, scriptBack.y*1.03, display.contentWidth*0.75, 150, "content/font/NanumBarunGothic.ttf", 35) 
	script.width = display.contentWidth*0.6
	script.align = "left"
	script:setFillColor(0.61, 0.31, 0)
	script.alpha = 0
	--이마, 입, 머리 tap 횟수
	local tapS = 0
	local tapF = 0
	local tapH = 0

    local function tapStomach(event)
        scriptBack.alpha = 1
		bodyName.alpha = 1
		endButton.alpha = 1
		script.text = "배에 칼로 찔린듯한 상처가 있다."
		bodyName.text = "배"
		script.alpha = 1
		tapS = 1
		local function tapEndButton(event)
			scriptBack.alpha = 0
			bodyName.alpha = 0
			endButton.alpha = 0
			script.alpha = 0
			if tapH == 1 and tapF == 1 and tapS == 1 then
				outButton.alpha = 1
			end
		end
		endButton:addEventListener("tap", tapEndButton)
	end
    stomach:addEventListener("tap", tapStomach)

    local function tapFace(event)
		scriptBack.alpha = 1
		bodyName.alpha = 1
		endButton.alpha = 1
		script.text = "입 주위에 하얀 가루가 묻어있다."
		bodyName.text = "입"
		script.alpha = 1
		tapF = 1
		composer.setVariable("clue2", 1)
		local function tapEndButton(event)
			scriptBack.alpha = 0
			bodyName.alpha = 0
			endButton.alpha = 0
			script.alpha = 0
			if tapH == 1 and tapF == 1 and tapS == 1 then
				outButton.alpha = 1
			end
		end
		endButton:addEventListener("tap", tapEndButton)
	end
    face:addEventListener("tap", tapFace)

	local function tapHead(event)
		scriptBack.alpha = 1
		bodyName.alpha = 1
		endButton.alpha = 1
		script.text = "30.5도,, 몸이 차갑다.\n죽은것으로 보인다."
		bodyName.text = "체온"
		script.alpha = 1
		tapH = 1
		local function tapEndButton(event)
			scriptBack.alpha = 0
			bodyName.alpha = 0
			endButton.alpha = 0
			script.alpha = 0
			if tapH == 1 and tapF == 1 and tapS == 1 then
				outButton.alpha = 1
			end
		end
		endButton:addEventListener("tap", tapEndButton)
	end
    head:addEventListener("tap", tapHead)

	local function onHead( event )
		if(head.x - 20 <= event.x and event.x <= head.x + 20)then
			if (head.y - 20 <= event.y and event.y <= head.y + 20) then
				head:setFillColor(1, 1, 0, 0.5);
			else
				head:setFillColor(1, 1, 0, 0.2);
			end
		else
			head:setFillColor(1, 1, 0, 0.2);
		end
	end
	head:addEventListener("mouse", onHead)

	local function onFace( event )
		if(face.x - 20 <= event.x and event.x <= face.x + 20)then
			if (face.y - 20 <= event.y and event.y <= face.y + 20) then
				face:setFillColor(1, 1, 0, 0.5);
			else
				face:setFillColor(1, 1, 0, 0.2);
			end
		else
			face:setFillColor(1, 1, 0, 0.2);
		end
	end
	face:addEventListener("mouse", onFace)

	local function onStomach( event )
		if(stomach.x - 50 <= event.x and event.x <= stomach.x + 50)then
			if (stomach.y - 50 <= event.y and event.y <= stomach.y + 50) then
				stomach:setFillColor(1, 1, 0, 0.5);
			else
				stomach:setFillColor(1, 1, 0, 0.2);
			end
		else
			stomach:setFillColor(1, 1, 0, 0.2);
		end
	end
	stomach:addEventListener("mouse", onStomach)

	local function tapOutButton(event)
		composer.removeScene("dead")
		composer.gotoScene("guessing")
	end
	outButton:addEventListener("tap", tapOutButton)
	--레이어 정리--
	sceneGroup:insert(background)
    sceneGroup:insert(body)
    sceneGroup:insert(face)
	sceneGroup:insert(head)
    sceneGroup:insert(stomach)
    sceneGroup:insert(scriptBack)
	sceneGroup:insert(bodyName)
    sceneGroup:insert(script)
    sceneGroup:insert(endButton)
	sceneGroup:insert(outButton)
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
		composer.removeScene("view1")
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