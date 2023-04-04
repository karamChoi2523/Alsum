-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view        
	local enter = 0
	local reEnter = 0
	local bedLoc
	local deskLoc
	local noteLoc = 0
	local eunjooSide
	--배경
	local background = display.newImage("content/image/gayeong/room.png")
	background.x , background.y = display.contentWidth /2, display.contentHeight /2

	local frame  = display.newImage("content/image/gayeong/frame.png")
	frame.x, frame.y = display.contentWidth /2, display.contentHeight /2

	--문
	local door = display.newImage("content/image/gayeong/room_door.png")
	door.x, door.y = display.contentWidth * 0.1, display.contentHeight * 0.56
	
	--침대
	local bed = display.newImage("content/image/gayeong/room_bed.png")
    bed.x ,bed.y = display.contentWidth * 0.88, display.contentHeight * 0.69
	--책상
    local desk = display.newImage("content/image/gayeong/room_desk.png")
	desk.x, desk.y = display.contentWidth*0.675, display.contentHeight * 0.62
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,866
	textBox.alpha = 0
	
	--단서노트버튼
	local noteB = display.newImage("content/image/note/note_s.png")
	noteB.x = 100
	noteB.y = 100

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
	
	--은주
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
    local eunjoo = display.newSprite(eunjooSheet, sequenceData)
	local eunjoo2 = display.newImage("content/image/character/eunjoo2.png")
	local eunjoo3 = display.newImage("content/image/character/eunjoo.png")
 
	if(composer.getVariable("eunjooLeft") == 1)then 
		eunjoo.alpha = 0
		eunjoo2.alpha = 1
		eunjoo3.alpha = 0
	elseif(composer.getVariable("eunjooRight") == 1) then 
		eunjoo.alpha = 0
		eunjoo2.alpha = 0
		eunjoo3.alpha = 1
	end
	eunjoo.x = display.contentWidth * 0.14
	eunjoo.y = display.contentHeight*0.68
	eunjoo3.x = eunjoo.x
	eunjoo3.y = eunjoo.y

	--locTrue = composer.getVariable("true")
	noteLoc = composer.getVariable("noteLoc")
	bedLoc = composer.getVariable("bedLoc")
	deskLoc = composer.getVariable("deskLoc")
	--침대 이후 다시 위치로
	if(noteLoc == 0 and deskLoc == 1 and bedLoc == 0) then
		eunjoo.x = desk.x
		deskLoc = 0
		bedLoc = 0
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
	elseif(noteLoc == 0 and bedLoc == 1 and deskLoc == 0)then
		eunjoo.x = bed.x
		deskLoc = 0
		bedLoc = 0
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
	elseif(reEnter == 1 and bedLoc == 0 and deskLoc == 0) then
		eunjoo.x = display.contentWidth * 0.14
		eunjoo.y = display.contentHeight*0.68
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
	elseif(noteLoc == 1) then
		eunjoo.x = composer.getVariable("gayeongHome")
		eunjoo3.x = eunjoo.x
		eunjoo3.y = eunjoo.y
		eunjoo2.x = eunjoo.x
		eunjoo2.y = eunjoo.y
		bedLoc = 0
		deskLoc = 0
		noteLoc = 0 
	end


	textBox.alpha = 0
	speaker.alpha = 0
	txt.alpha = 0
	local function move(event)
		--책상
		if (event.keyName == "enter") then
			if(event.phase == "down")then
				if (eunjoo.x >= desk.x-100 and eunjoo.x <=desk.x+100) then
					if(eunjoo2.alpha == 1)then  --왼쪽
						composer.setVariable("eunjooLeft", 1)
						composer.setVariable("eunjooRight", 0)
					else
						composer.setVariable("eunjooLeft", 0)
						composer.setVariable("eunjooRight", 1)
					end
					composer.removeScene("gayeongHome")
					print("enter")
					composer.gotoScene("gayeongDesk")
				elseif (eunjoo.x >= bed.x-100 and eunjoo.x <= bed.x+100) then
					if(eunjoo2.alpha == 1)then  --왼쪽
						composer.setVariable("eunjooLeft", 1)
						composer.setVariable("eunjooRight", 0)
					else
						composer.setVariable("eunjooLeft", 0)
						composer.setVariable("eunjooRight", 1)
					end
					composer.removeScene("gayeongHome")
					print("enter")
					composer.gotoScene("bed")
				elseif (eunjoo.x > door.x-100 and eunjoo.x <= door.x + 100) then
					if( composer.getVariable("clue6") == 1 and composer.getVariable("clue5") == 1) then	
						print("enter")
						reEnter = 1 --위치를 위한
						composer.setVariable("bedLoc",0)
			 			composer.setVariable("deskLoc", 0)
						composer.setVariable("goToMap3",3)
						composer.setVariable("noteLoc", 0) 
						composer.setVariable("eunjooLeft", 0)
						composer.setVariable("eunjooRight", 1)
						Runtime:removeEventListener("key", move)
						composer.removeScene("gayeongHome")
						composer.gotoScene("map3")
					elseif(enter == 0) then
						textBox.alpha = 0
						speaker.alpha = 0
						txt.alpha = 0
						enter = 1
					else
						textBox.alpha = 1
						speaker.alpha = 1
						txt.alpha = 1
						txt.text = "아직 나갈 수 없어"
					end
				end
			elseif(txt.alpha == 0 and eunjoo.x > door.x + 100 ) then
				textBox.alpha = 1
				speaker.alpha = 1
				txt.text = "여기에는 아무 것도 없네"
				txt.alpha = 1
			end
		else
			txt.alpha = 0
			speaker.alpha = 0
			txt.text = ""
			textBox.alpha = 0
			
		end
		--좌우이동
     --좌우이동
	 if (event.phase == "down") then
		if (event.keyName == "right" or event.keyName == "left") then
		   eunjoo.alpha = 1
		   eunjoo2.alpha = 0
		   eunjoo3.alpha = 0
		   if (event.keyName == "right") then
			  eunjoo:setSequence("right")
			  eunjoo:play()
			  transition.moveBy( eunjoo, { x= display.contentWidth-eunjoo.x, time = (display.contentWidth - eunjoo.x)*2} )
		   elseif (event.keyName == "left") then
			  eunjoo:setSequence("left")
			  eunjoo:play()
			  if (eunjoo.x >= 0) then
				 transition.moveBy( eunjoo, { x= -eunjoo.x, time = eunjoo.x * 2} )
			  end
		   end
		end
	 --멈춤
	 elseif (event.phase == "up") then
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
		if(eunjoo2.alpha == 1)then  --왼쪽
			composer.setVariable("eunjooLeft", 1)
			composer.setVariable("eunjooRight", 0)
		else
			composer.setVariable("eunjooLeft", 0)
			composer.setVariable("eunjooRight", 1)
		end
		composer.setVariable("gayeongHome", eunjoo.x)
		composer.setVariable("scene",6)
		composer.setVariable("noteLoc", 1) 
		composer.removeScene("gayeongHome")
		composer.gotoScene("note")
	end
	noteB:addEventListener("tap",gotoNote)
	
    --레이어정리
	sceneGroup:insert(background)
	sceneGroup:insert(door)
	sceneGroup:insert(bed)
    sceneGroup:insert(desk)
    sceneGroup:insert(eunjoo)
	sceneGroup:insert(eunjoo2)
	sceneGroup:insert(eunjoo3)
	sceneGroup:insert(textBox)
	sceneGroup:insert(speaker)
	sceneGroup:insert(txt)
	sceneGroup:insert(frame)
	sceneGroup:insert(noteB)
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