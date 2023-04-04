-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local json = require('json')

local Data, pos, msg

--파싱을 하는 함수
local function parse()
	-- 경로를 이용해 파일 가져오기
	local filename = system.pathForFile("content/json/findPoison.json")
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

	--밑판
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0 )
	--배경 위에 검은색
	local black =  display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
    black:setFillColor(0)
    black.alpha = 0
	--책상
	local desk = display.newImage("content/image/Gong/desk.png")
	desk.x, desk.y = display.contentCenterX, display.contentCenterY
	--책상 위 물건들
	--달력
	local calender = display.newImage("content/image/Gong/calender.png")
	calender.x, calender.y = desk.x*0.53, desk.y*0.35
	--종이컵들
	local cup = {}
	local cupGroup = display.newGroup()

	for i=3,1,-1 do
		cup[i] = display.newImage(cupGroup, "content/image/Gong/cup.png")
		cup[i].x = desk.x*(0.11*(i-1))
	end
	cup[1].y = desk.y*0.66
	cup[2].y = desk.y*0.5
	cup[3].y = desk.y*0.73

	cupGroup.x = desk.x*1.45

	--책
	local book = display.newImage("content/image/Gong/book.png")
	book.x, book.y = display.contentWidth*0.56, display.contentHeight*0.4
	
	--서랍 열고 닫기
	local close = 0;
	--서랍 열리는 소리
	local sound = audio.loadSound("content/audio/drawer.mp3")
	--서랍
	local drawer = display.newImage("content/image/Gong/drawer1.png")
	drawer.x, drawer.y = display.contentWidth*0.22, display.contentHeight*0.89
	--열린 서랍
	local drawer2 = display.newImage("content/image/Gong/drawer2.png")
	drawer2.x, drawer2.y = display.contentWidth*0.22, display.contentHeight*0.89
	drawer2.alpha = 0

	--서랍 속 약병
	local poison2 = display.newImage("content/image/Gong/drugInD.png")
	poison2.x, poison2.y = display.contentWidth*0.28, display.contentHeight*0.77
	poison2.alpha = 0
	--약병 발견
	local poison = display.newImage("content/image/clue/poison.png")
	poison.x, poison.y = display.contentWidth /2, display.contentHeight *0.4
	poison.alpha = 0
	--은주 이미지
	local speakerImg = display.newRect(display.contentCenterX, display.contentCenterY,970,1080)
	speakerImg.alpha = 0
	
	--텍스트상자
	local textBox = display.newImage("content/image/narration/textbox.png")
	textBox.x, textBox.y = display.contentWidth/2,display.contentHeight*0.82
	textBox.alpha = 0
	
	--다음 버튼
	local next = display.newImage("content/image/narration/nextB.png")
	next.x, next.y = display.contentWidth * 0.85, display.contentHeight * 0.89
	next.alpha = 0
	--이름
	local textParams = { text = "송은주", 
						x =  textBox.x*0.34,
						y = textBox.y*0.85,
						font = "content/font/NanumBarunGothic.ttf", 
						fontSize = 27, 
						align = "center" }
	local name = display.newText(textParams)
	name:setFillColor(1)
	name.alpha = 0
	--대사
	local newTextParams = { text = "약병이잖아?", 
						x = textBox.x,
						y = textBox.y*1.03,
						width =  display.contentWidth*0.75,
						height = 150,
						font = "content/font/NanumBarunGothic.ttf", fontSize = 35, 
						align = "left" }
	local script =  display.newText(newTextParams)
	script:setFillColor(0.61, 0.31, 0)
	script.alpha = 0
	--나가기
	local goOut = display.newImage("content/image/clue/diary_exitB.png")
	goOut.x, goOut.y = display.contentWidth * 0.92, display.contentHeight * 0.09
	goOut.alpha = 0
	--돌아가기
	local goBack = display.newImage("content/image/narration/returnB.png")
	goBack.x, goBack.y = display.contentWidth * 0.85, display.contentHeight * 0.89
	goBack.alpha = 0

	if composer.getVariable("clue7")==1 then
		drawer.alpha = 0
		drawer2.alpha = 1
		poison2.alpha = 0
		goOut.alpha = 1
		goOut.x, goOut.y = display.contentWidth * 0.9, display.contentHeight * 0.1
	end

	--대사창 뜸
	local function openTextBox()
		black.alpha = 0.2
		textBox.alpha = 1
		name.alpha = 1
		goBack.alpha = 1
		script.alpha = 1
	end
	
	--script
	local index = 1
	local function nextScript( ... )
		next.alpha = 0
		if(index <= #Data) then
			if(Data[index].type == "Narration") then
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				textBox.alpha = 1
				name.alpha = 1
				script.alpha = 1
				next.alpha = 1

				script.text = Data[index].content
				index = index + 1
			end
		end
		if (index == #Data + 1) then
			goBack.alpha = 1
		end
	end
	
	--서랍 열기
	local function openDrawer(event)
		audio.play(sound);
		drawer.alpha = 0
		drawer2.alpha = 1
		if composer.getVariable("clue7")~=1 then
			poison2.alpha = 1
		end
	end
	drawer:addEventListener("tap", openDrawer)

	local function closeDrawer(event)
		if(close == 0) then
			audio.play(sound);
			drawer.alpha = 1
			drawer2.alpha = 0
			poison2.alpha = 0
		end
	end
	drawer2:addEventListener("tap", closeDrawer)

	--약병 클릭
	local function getPoison(event)
		close = 1;
		openTextBox()
		poison.alpha = 1
		next.alpha = 1
		goBack.alpha=0
		name.text = "송은주"
		script.text = "약병이잖아?"
	end
	poison2:addEventListener("tap", getPoison)

	--약 찾고 대사
	local function scriptStart(event)
		poison.alpha = 0
		nextScript()
	end
	next:addEventListener("tap", scriptStart)
	
	--방으로 돌아가기
	local function gotoRoom()
		composer.setVariable("gongHome", 1)
		composer.setVariable("clue7", 1)
		composer.removeScene("gongDesk")
		composer.gotoScene("searchGong")
	end

	local function getOut(event)
		gotoRoom()
	end
	goOut:addEventListener("tap", getOut)

	local function gotoDesk(event)
		if(index == 1) then
			black.alpha = 0
			textBox.alpha = 0
			name.alpha = 0
			script.alpha = 0
			goBack.alpha = 0
		else
			gotoRoom()
		end
	end
	goBack:addEventListener("tap", gotoDesk)

	--물건별 대사 추가
	--달력클릭
	local function clickCalender(event)
		if(textBox.alpha == 0 ) then
			openTextBox()
			name.text = "달력"
			script.text = "달력이다. 달리 표시된 것은 없다."
		end
	end
	calender:addEventListener("tap", clickCalender)
	--책클릭
	local function clickBook(event)
		if(textBox.alpha == 0 ) then
			openTextBox()
			name.text = "종교책"
			script.text = "종교서적이다. 안에 적혀있는 것은 이장이 만든 사이비 종교의 교리로 보인다."
		end
	end
	book:addEventListener("tap", clickBook)
	--컵클릭
	local function clickCup(event)
		if(textBox.alpha == 0 ) then
			openTextBox()
			name.text = "종이컵"
			script.text = "종이컵이 잔뜩 있다. 그냥 빈 종이컵이다."
		end
	end
	cupGroup:addEventListener("tap", clickCup)

	--레이어정리
	sceneGroup:insert(background)
	sceneGroup:insert(desk)
	sceneGroup:insert(calender)
	sceneGroup:insert(cupGroup)
	sceneGroup:insert(book)
	sceneGroup:insert(drawer)
	sceneGroup:insert(drawer2)
	sceneGroup:insert(poison2)
	sceneGroup:insert(black)
	sceneGroup:insert(poison)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(textBox)
	sceneGroup:insert(name)
	sceneGroup:insert(script)
	sceneGroup:insert(next)
	sceneGroup:insert(goOut)
	sceneGroup:insert(goBack)
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