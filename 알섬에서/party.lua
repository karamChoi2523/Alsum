-----------------------------------------------------------------------------------------
--
-- party.lua
--
-----------------------------------------------------------------------------------------
--JSON 파싱
local json = require('json')
local Data, pos, msg

local function parse()
	local filename = system.pathForFile("content/JSON/partyStory.json")
	Data, pos, msg = json.decodeFile(filename)
	--디버그
	if Data then
		print(Data[1].title)
	else
		print(pos)
		print(msg)
	end
	--
end
parse()

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local options =
	{ 
		effect = "fade",
    	time = 1000
    }
	--배경
	local background = display.newImage("content/image/villageHall/villageHall.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY
	--대화창
	local scriptBack = display.newImage("content/image/narration/textbox.png", display.contentWidth/2, display.contentHeight*0.82)
	--대사
	local script = display.newText("더미 텍스트입니다.", scriptBack.x, scriptBack.y*1.03, display.contentWidth*0.75, 150, "content/font/NanumBarunGothic.ttf", 35)
	script.width = display.contentWidth*0.6
	script:setFillColor(0.61, 0.31, 0)
	script.align = "left"
	--화자이미지
	local speakerImg = display.newRect(display.contentCenterX, display.contentCenterY, 970.6,1080)
	speakerImg.alpha = 0
	--화자이름
	local speakerName = display.newText("", scriptBack.x*0.34, scriptBack.y*0.85,"content/font/NanumBarunGothic.ttf", 27)
	speakerName:setFillColor(1)
	--다음버튼
	local next = display.newImage("content/image/narration/nextB.png")
	next.x, next.y = display.contentWidth*0.85, display.contentHeight*0.89
	
	local index = 1
	local function nextScript(   )
		if (index <= #Data) then
			audio.play(partySound)
			if (Data[index].type == "background") then
				index = index + 1
				nextScript()
				--은주 속마음
			elseif(Data[index].type == "Narration") then
				speakerImg.alpha = 0
				speakerName.alpha = 1
				speakerName.text = Data[index].speaker
				script.text = Data[index].content
				index = index + 1
			elseif(Data[index].type == "NarrationLast") then
				speakerImg.alpha = 0
				speakerName.alpha = 1
				speakerName.text = Data[index].speaker
				script.text = Data[index].content
				index = index + 1
				background.alpha = 0
				--대사
			elseif(Data[index].type == "Dialogue") then
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				speakerName.alpha = 1
				speakerName.text = Data[index].speaker
				script.text = Data[index].content
				index = index + 1
				--속마음
			elseif(Data[index].type == "Inner") then
				speakerImg.alpha = 0
				speakerName.alpha = 1
				speakerName.text = Data[index].speaker
				script.text = Data[index].content
				index = index + 1
			end
		else
			composer.setVariable("permitMap2", 1)
			composer.setVariable("goToParty", 0)
			composer.gotoScene("suspectEunjoo", options)
			composer.removeScene("party")
		end
	end
	nextScript()

	local function tap(event)
		nextScript()
	end
	next:addEventListener("tap", tap)

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(scriptBack)
	sceneGroup:insert(speakerName)
	sceneGroup:insert(script)
	sceneGroup:insert(next)
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
		composer.removeScene("view3")
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