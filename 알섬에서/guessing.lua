-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------
local json = require('json')

local Data, pos, msg

--파싱을 하는 함수
local function parse()
	-- 경로를 이용해 파일 가져오기
	local filename = system.pathForFile("content/json/gatherEvidence.json")
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
	--배경
	local background = display.newImage("content/image/background/village.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY
	--텍스트상자
	local textBox = display.newImage("content/image/narration/textbox.png",display.contentCenterX, display.contentHeight)
	textBox.x, textBox.y = display.contentWidth/2,display.contentHeight*0.82
	textBox.alpha = 0
	--다음 버튼
	local next = display.newImage("content/image/narration/nextB.png")
	next.x, next.y = display.contentWidth * 0.85, display.contentHeight * 0.89
	next.alpha = 0
	--화자 이미지
	local speakerImg = display.newRect(display.contentCenterX, display.contentCenterY,970,1080)
	--이름
	local textParams = { text = "송은주", 
						x =  textBox.x*0.34, 
						y = textBox.y*0.85,
						font = "content/font/NanumBarunGothic.ttf", 
						fontSize = 27, 
						align = "center" }
	local speaker = display.newText(textParams)
	speaker:setFillColor(1)
	--대사
	local newTextParams = { text = "더미텍스트", 
						x = textBox.x,
						y = textBox.y*1.03,
						width =  display.contentWidth*0.75,
						height = 150,
						font = "content/font/NanumBarunGothic.ttf", fontSize = 35, 
						align = "left" }
	local script =  display.newText(newTextParams)
	script:setFillColor(0.61, 0.31, 0)

	--script
	local index = 1
	local function nextScript( ... )
		if(index <= #Data) then
			if(Data[index].type == "Narration") then
				speakerImg.alpha = 0
				textBox.alpha = 1
				next.alpha = 1
				speaker.alpha = 1

				script.text = Data[index].content

				index = index + 1

			elseif(Data[index].type == "Dialogue")then
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				next.alpha = 1
				textBox.alpha = 1
				speaker.alpha = 1
				script.text = Data[index].content
				index = index + 1
			end
		else
			composer.setVariable("toMap1", 4);
			composer.gotoScene("map1")
		end
	end
	nextScript()

	--배경 클릭하면 넘어가게 하는 기능 구현
	local function tap(event)
		nextScript()
	end
	next:addEventListener("tap", tap)


	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(textBox)
	sceneGroup:insert(next)
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
		composer.removeScene("guessing")
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
