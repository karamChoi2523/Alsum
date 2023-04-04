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
	local filename = system.pathForFile("content/json/findSafe.json")
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
	--진짜 배경
	local bg = display.newImage("content/image/Gong/wall.png")
	bg.x, bg.y = display.contentCenterX, display.contentCenterY
	--검은색깔기
	local black =  display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
    black:setFillColor(0)
    black.alpha = 0
	--책장
	local bookshelf = display.newImage("content/image/Gong/bookshelf.png")
	bookshelf.x, bookshelf.y = display.contentCenterX, display.contentCenterY*1.12

	--책 누르기
	local btn = display.newRect(display.contentWidth*0.39, display.contentHeight*0.41,54,300)
	btn.alpha = 0.02
	--암호버튼
	local btn2 = display.newRect(display.contentWidth*0.635, display.contentHeight*0.8,190,240)
	btn2.alpha = 0.02
	--암호
	local pw = display.newImage("content/image/Gong/clue.png")
	pw.x, pw.y = btn2.x*1., btn2.y*0.85
	pw.alpha = 0
	--통장(금고 속 통장)
	local bankbook = display.newImage("content/image/Gong/bankbookInSafe.png")
	bankbook.x, bankbook.y = display.contentWidth*0.38, display.contentHeight*0.5
	bankbook.alpha = 0
	--통장(대사 이미지)
	local bankbook2 = display.newImage("content/image/clue/bank.png")
	bankbook2.x, bankbook2.y = display.contentWidth /2, display.contentHeight *0.4
	bankbook2.alpha = 0
	
	--은주 이미지
	local speakerImg = display.newRect(display.contentCenterX, display.contentCenterY,970,1080)
	speakerImg.alpha = 0

	--금고
	local safe = display.newImage("content/image/Gong/safeClose.png")
	safe.x, safe.y = display.contentWidth*0.42, display.contentHeight/2
	safe.alpha = 0
	--열린 금고
	local safe2 = display.newImage("content/image/Gong/safeOpen.png")
	safe2.x, safe2.y = display.contentWidth*0.46, display.contentHeight/2
	safe2.alpha = 0
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
	local newTextParams = { text = "통장이다!", 
						x = textBox.x,
						y = textBox.y*1.03,
						width =  display.contentWidth*0.75,
						height = 150,
						font = "content/font/NanumBarunGothic.ttf", fontSize = 35, 
						align = "left" }
	local script =  display.newText(newTextParams)
	script:setFillColor(0.61, 0.31, 0)
	script.alpha = 0
	--나가기 버튼
	local goOut = display.newImage("content/image/clue/diary_exitB.png")
	goOut.x, goOut.y = display.contentWidth * 0.92, display.contentHeight * 0.09
	goOut.alpha = 0
	--대화 끝
	local goBack = display.newImage("content/image/narration/returnB.png")
	goBack.x, goBack.y = display.contentWidth * 0.85, display.contentHeight * 0.89
	goBack.alpha = 0
	--단서 찾았는데 다시 들어옴
	if composer.getVariable("found8")==1 then
		btn.alpha = 0
		btn2.alpha = 0
		safe2.alpha = 1
		goOut.alpha = 1
		bankbook.alpha = 0
		bookshelf.x = display.contentWidth*0.85
	--금고 열림
	elseif composer.getVariable("clue8") ==1 then
		--금고 열리는 끼익 소리
		local sound = audio.loadSound("content/audio/open.m4a")
		audio.play(sound)
		btn.alpha = 0
		btn2.alpha = 0
		bankbook.alpha = 1
		safe.alpha = 0
		safe2.alpha = 1
		bookshelf.x = display.contentWidth*0.85
	--단서 찾으러 금고 열다가 다시 방으로
	elseif composer.getVariable("fail")==1 then
		safe.alpha = 1
		btn2.alpha = 0.02
		btn2.x = display.contentWidth
		pw.x = display.contentWidth*0.85
		bookshelf.x = display.contentWidth*0.85
	end

	--script
	local index = 1
	local function nextScript( ... )
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

	--금고 찾기
	local function findSafe(event)
		local sound = audio.loadSound("content/audio/movingBookshelf.m4a")
		audio.play(sound)
		btn.alpha = 0
		safe.alpha = 1
		transition.to( bookshelf, { time=1000, x=display.contentWidth*0.85} )
		transition.to( btn2, { time=1000, x=display.contentWidth} )
		transition.to( pw, { time=1000, x=display.contentWidth*0.85} )
	end
	btn:addEventListener("tap", findSafe)
	--암호 찾기
	local function pwSafe(event)
		btn2.alpha = 0
		pw.alpha = 1
	end
	btn2:addEventListener("tap", pwSafe)

	--암호 찾기
	local function pwClose(event)
		btn2.alpha = 0.02
		pw.alpha = 0
	end
	pw:addEventListener("tap", pwClose)

	--단서 찾기
	local function findClue(event)
		
		--composer.setVariable("clue8", 1)
		--if composer.getVariable("found2")==nil then
		--	textBox.alpha = 1
		--	name.alpha = 1
		--	next.alpha = 1
		--	script.alpha = 1
		--else
		--	textBox.alpha = 1
		--	name.alpha = 1
		--	next.alpha = 1
		--	script.alpha = 1
		--	script.text = "통장은 이미 찾았어."
		--	did = 1
		--end
		composer.removeScene("gongBookshelf")
		composer.gotoScene("openSafe")
	end
	safe:addEventListener("tap", findClue)

	--찾은 뒤 다시 방으로
	local function gotoRoom(event)
		composer.setVariable("gongHome", 2)
		composer.setVariable("clue8", 1)
		composer.removeScene("gongBookshelf")
		composer.gotoScene("searchGong")
	end
	goBack:addEventListener("tap", gotoRoom)
	goOut:addEventListener("tap", gotoRoom)
	--대사
	local function scriptStart(event)
		bankbook2.alpha = 0
		nextScript()
	end
	next:addEventListener("tap", scriptStart)
	--통장 클릭
	local function getbankbook(event)
		black.alpha = 0.2
		bankbook2.alpha = 1
		textBox.alpha = 1
		name.alpha = 1
		script.alpha = 1
		next.alpha = 1
	end
	bankbook:addEventListener("tap", getbankbook)

	--레이어정리
	sceneGroup:insert(background)
	sceneGroup:insert(bg)
	sceneGroup:insert(safe)
	sceneGroup:insert(bookshelf)
	sceneGroup:insert(safe2)
	sceneGroup:insert(bankbook)
	sceneGroup:insert(btn)
	sceneGroup:insert(btn2)
	sceneGroup:insert(pw)
	sceneGroup:insert(black)	
	sceneGroup:insert(bankbook2)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(textBox)
	sceneGroup:insert(name)
	sceneGroup:insert(script)
	sceneGroup:insert(next)
	sceneGroup:insert(goBack)
	sceneGroup:insert(goOut)
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