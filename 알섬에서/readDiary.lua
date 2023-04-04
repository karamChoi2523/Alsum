-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

--JSON 파싱__
local json = require('json')

local Data, pos, msg

local function parse()
	local filename = system.pathForFile("content/json/diary.json")
	Data, pos, msg = json.decodeFile(filename)

	--디버그
	if Data then
		print(Data[1].type)
	else
		print(pos)
		print(msg)
	end
end
parse()

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    --책넘기는 소리
    local turnPageAudio =audio.loadSound("content/audio/turnPage.mp3")
	--배경
	local background = display.newImage("content/image/clue/diaryBackground.png")
    background.x, background.y = display.contentWidth / 2,display.contentHeight / 2
    
    --왼쪽 버튼
    local preB = display.newImage("content/image/clue/diary_precedingB.png")
    preB.x, preB.y = display.contentWidth *0.235, display.contentHeight * 0.795
    preB:setFillColor(0.6)
    --오른쪽 버튼
    local nxtB = display.newImage("content/image/clue/diary_nextB.png")
    nxtB.x, nxtB.y = display.contentWidth *0.765, display.contentHeight * 0.795
    nxtB:setFillColor(0.6)

    --나가기 버튼 
    local exitB = display.newImage("content/image/clue/diary_exitB.png")
    exitB.x, exitB.y = display.contentWidth * 0.92, display.contentHeight * 0.09
    exitB.alpha = 0

    --왼쪽 대사 위치
    local leftScript = display.newText("더미 텍스트", display.contentWidth*0.35, display.contentHeight * 0.453, "content/font/나눔손글씨+성실체.ttf")
    leftScript.width = display.contentWidth*0.6
    leftScript.size = 40
    leftScript:setFillColor(0.61, 0.31, 0)

    --오른쪽 대사 위치
    local rightScript = display.newText("더미 텍스트", display.contentWidth*0.67, display.contentHeight * 0.458, "content/font/나눔손글씨+성실체.ttf")
    rightScript.width = display.contentWidth*0.6
    rightScript.size = 40
    rightScript:setFillColor(0.61, 0.31, 0)

    --대사
    local index = 1
    --local rIndex = index * 2
	local function turnPage()
		if(2 *index - 1<= #Data) then
            --버튼 유무
			if(index == 1) then
				preB.alpha = 0
            elseif(2 * index - 1 == #Data) then
                nxtB.alpha = 0
                exitB.alpha = 1
            else
                preB.alpha = 1
                nxtB.alpha = 1
                exitB.alpha = 0
            end
            leftScript.text = Data[2 * index - 1].content
            if(index < 3) then
                rightScript.alpha = 1
                rightScript.text = Data[2 * index].content
            elseif(index == 3) then
                rightScript.alpha = 0
            end

            transition.fadeIn( leftScript, { time=5500 } )
		end
	end


    local function nxtIndex()
        audio.play(turnPageAudio)
        index = index + 1
        turnPage()
    end

    local function preIndex()
        index = index - 1
        audio.play(turnPageAudio)
        turnPage()
    end
    
    turnPage()

    local function backToHome()
        composer.setVariable("bedLoc", 0)
		composer.setVariable("deskLoc", 1)
        composer.setVariable("noteLoc", 0) 
        composer.setVariable("clue6", 1)
		composer.gotoScene("gayeongHome")
    end

    --탭이벤트
    nxtB:addEventListener("tap", nxtIndex)
    preB:addEventListener("tap", preIndex)
    exitB:addEventListener("tap", backToHome)

    --마우스 올리면 선명하짐
    local function nxtBOver(event)
        if(nxtB.x - 50 <= event.x and event.x <= nxtB.x + 50)then
            if(nxtB.y - 20 <= event.y and event.y <= nxtB.y + 20)then
                nxtB:setFillColor(1)
            else
                nxtB:setFillColor(0.6)
                preB:setFillColor(0.6)
            end
        else
            nxtB:setFillColor(0.6)
            preB:setFillColor(0.6)
        end
    end

    local function preBOver(event)
        if(preB.x - 50 <= event.x and event.x <= preB.x + 50)then
            if(preB.y - 20 <= event.y and event.y <= preB.y + 20)then
                preB:setFillColor(1)
            else
                nxtB:setFillColor(0.6)
                preB:setFillColor(0.6)
            end
        else
            nxtB:setFillColor(0.6)
            preB:setFillColor(0.6)
        end
    end
    --마우스 이벤트
    nxtB:addEventListener("mouse", nxtBOver)
    preB:addEventListener("mouse", preBOver)

    --레이어 정리
    sceneGroup:insert( background )
	sceneGroup:insert( preB )
	sceneGroup:insert( nxtB )
    sceneGroup:insert( exitB )
    sceneGroup:insert(leftScript)
    sceneGroup:insert(rightScript)
    sceneGroup:insert( exitB )
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