-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

--JSON 파싱__
local json = require('json')

local Data, pos, msg
local runAway = audio.loadSound("content/audio/running.mp3")
local function parse()
	local filename = system.pathForFile("content/json/suspectEunjoo.json")
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
--
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local options =
	{ 
		effect = "fade",
    time = 3000,
    }

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(0,0,0,0.2)

	--화자 이미지--
	local speakerImg = display.newRect(display.contentWidth / 2, display.contentHeight / 2, 970.6,1080)
	speakerImg:setFillColor(1)
	local deadImg = display.newImage("content/image/dead/dead.png")
	deadImg.x, deadImg.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	deadImg.alpha = 0
	--대화창--
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth / 2, display.contentHeight*0.82

	--다음버튼--
	local nextB = display.newImage("content/image/narration/nextB.png")
	nextB.x, nextB.y = display.contentWidth * 0.85, display.contentHeight* 0.89


	--이름--
	local speaker = display.newText("송은주", textBox.x*0.34, textBox.y*0.85,"content/font/NanumBarunGothic.ttf") 
	speaker.size = 27
	speaker:setFillColor(1)
	--대사위치--
	local script = display.newText("더미 텍스트", textBox.x,textBox.y*1.03, display.contentWidth*0.75, 150,"content/font/NanumBarunGothic.ttf") 
	script.width = display.contentWidth*0.6
	script.size = 35
	script.align = "left"
	script:setFillColor(0.61, 0.31, 0)

	--대사--
	local index = 1
	local function nextScript()
		if(index <= #Data + 1 ) then
			if(Data[index].type == "background") then
				background.fill = {
					type = "image",
					filename = Data[index].img}
				deadImg.alpha = 0
				index = index + 1

				nextScript()

			elseif(Data[index].type == "Narration") then
				deadImg.alpha = 0
				speakerImg.alpha = 0 
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				background.fill = {
					type = "image",
					filename = Data[index].background
				}
				textBox.alpha = 1
				speaker.text = Data[index].speaker
				speaker.alpha = 1
				script.alpha = 1
				script.text = Data[index].content
				index = index + 1
				nextB.alpha = 1
			elseif(Data[index].type == "Dialogue")then
				deadImg.alpha = 0
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				background.fill = {
					type = "image",
					filename = Data[index].background
				}
				script.alpha = 1
				textBox.alpha = 1
				speaker.alpha = 1
				speaker.text = Data[index].speaker
				nextB.alpha = 1
				script.text = Data[index].content
				index = index + 1
			elseif(Data[index].type == "foundDead") then
				speakerImg.alpha = 0
				deadImg.alpha = 0
				background.alpha = 0
				background.fill = {
					type = "image",
					filename = Data[index].background
				}
				transition.fadeIn( deadImg, { time=1500 } )
				transition.fadeIn( background, { time=1500 } )
				nextB.alpha = 1
				textBox.alpha = 0
				speaker.alpha = 0
				script.alpha = 0
				index = index + 1
			end
		end
		if(index > #Data)then
			speakerImg.alpha = 0
			audio.play(runAway)
			composer.setVariable("toMap1", 4)
			composer.removeScene("suspectEunjoo")
			composer.gotoScene("map1", options)
		end
	end

	--if(index ~= 1)then 
	nextScript()
	--end

	local function tap(event)
		nextScript()
	end
	local function tap2(event)
		index = index + 1
		nextScript()
	end
	nextB:addEventListener("tap", tap)

	--마자막에 오디오 추가
	local function runAway( event )
		audio.play("runAway")
	end
	 
	--레이어정리
	sceneGroup:insert(background)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(deadImg)
	sceneGroup:insert(textBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(script)
	sceneGroup:insert(nextB)
	
	
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
