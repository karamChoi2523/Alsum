-----------------------------------------------------------------------------------------
--
-- note.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
   local sceneGroup = self.view

   --[[explain1= display.newText("다이어리",1230,170)
   explain1.anchorX,explain1.anchorY = 0,0
   explain1:setFillColor(0)
   explain1.alpha = 0
   explain1.size = 60

   explain1_1= display.newText("주가영 책상에서 발견됨\n 다이어리 내용에는 ",1150,400)
   explain1_1.anchorX,explain1_1.anchorY = 0,0
   explain1_1:setFillColor(0)
   explain1_1.alpha = 0
   explain1_1.size = 40

   explain2= display.newText("메시지",1230,170)
   explain2.anchorX,explain2.anchorY = 0,0
   explain2:setFillColor(0)
   explain2.alpha = 0
   explain2.size = 60

   explain2_1= display.newText("설명",1230,300)
   explain2_1.anchorX,explain2_1.anchorY = 0,0
   explain2_1:setFillColor(0)
   explain2_1.alpha = 0
   explain2_1.size = 40

   explain3= display.newText("옷차림",1230,170)
   explain3.anchorX,explain3.anchorY = 0,0
   explain3:setFillColor(0)
   explain3.alpha = 0
   explain3.size = 60

   explain3_1= display.newText("설명",1230,300)
   explain3_1.anchorX,explain3_1.anchorY = 0,0
   explain3_1:setFillColor(0)
   explain3_1.alpha = 0
   explain3_1.size = 40

   explain4= display.newText("입",1230,170)
   explain4.anchorX,explain4.anchorY = 0,0
   explain4:setFillColor(0)
   explain4.alpha = 0
   explain4.size = 60

   explain4_1= display.newText("설명",1230,300)
   explain4_1.anchorX,explain4_1.anchorY = 0,0
   explain4_1:setFillColor(0)
   explain4_1.alpha = 0
   explain4_1.size = 40

   explain5= display.newText("음료수",1210,165)
   explain5.anchorX,explain5.anchorY = 0,0
   explain5:setFillColor(0)
   explain5.alpha = 0
   explain5.size = 60

   explain5_1= display.newText("주가영에게 마시라고 줌",1205,300)
   explain5_1.anchorX,explain5_1.anchorY = 0,0
   explain5_1:setFillColor(0)
   explain5_1.alpha = 0
   explain5_1.size = 40]]

   local titleParams = { text = "단서 이름", 
						x =  display.contentWidth*0.69, 
						y = display.contentHeight*0.18,
						font = "content/font/나눔손글씨+성실체.ttf", 
						fontSize = 60, 
						align = "center" }
   local title = display.newText(titleParams)
   title:setFillColor(0)
   title.alpha=0

   local explainParams = {text = "단서 설명\n단서 설명", 
                     x =  display.contentWidth*0.69, 
                     y = display.contentHeight*0.47,
                     font = "content/font/나눔손글씨+성실체.ttf", 
                     fontSize = 40, 
                     align = "center"}
   local explain = display.newText(explainParams)
   explain:setFillColor(0)
   explain.alpha = 0

 

   local function touch1(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "다이어리"
      explain.text = "주가영 책상에서 발견됨\n 다이어리에는 주가영 부모님께서 공진석(교주)의\n요구로 거액의 돈을 기부한 내용과\n그 거액의 돈이 교주 사비로 사용된 내용이 있음\n\n 용의자 : 공진석(교주)"
   end

   local function touch2(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "메시지"
      explain.text = "주가영 침대에서 핸드폰 발견됨\n핸드폰 최근 연락 목록에\n공진석(교주), 한상혁, 조애경이 있음\n\n 용의자 : 공진석(교주), 한상혁, 조애경"
   end

   local function touch3(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "옷차림"
      explain.text = "박다온(아이)와의 얘기를 통해\n주가영에게 음료수를 건낸 사람이\n아저씨임을 알게됨\n\n 용의자 : 공진석(교주), 한상혁"
   end

   local function touch4(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "주가영 입"
      explain.text = "죽은 주가영 입에서 흰 가루가 묻어있음\n입 주변(흰 가루)에서 독특한 냄새가 남\n\n 용의자 : 교주 생일잔치에 참석한 사람들"
   end

   local function touch5(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "음료수"
      explain.text = "박다온(아이)와의 얘기를 통해\n주가영에게 누군가가\n음료수를 건낸 것을 앎\n\n 용의자 : 교주 생일잔치에 참석한 사람들"
   end

   local function touch6(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "약(흰 가루)"
      explain.text = "공진석(교주)집 책상 서랍에서 나옴\n약병에서 독특한 냄새가 남\n죽은 주가영 입 주변에 흰 거품이 묻어있었음\n죽은 주가영 입에서 독특한 냄새가 났음\n\n 용의자 : 공진석"
   end

   local function touch7(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "의심"
      explain.text = "박다온(아이)와의 얘기를 통해\n주가영에게 음료수를 건낸 사람이\n남자임을 알게됨\n\n 용의자 : 공진석(교주), 한상혁"
   end

   local function touch8(event)
      title.alpha = 1
      explain.alpha = 1
      title.text = "통장"
      explain.text = "통장에 거액의 돈이 들어있음\n주가영 일기장에 적힌 내용과 조합해보면\n공진석(교주)가 신자들에게 받은 기부금을\n횡령한 결정적 증거임\n\n 용의자 : 공진석(교주)"
   end

   local noteBackground = display.newImage( "content/image/note/noteBackground.png", display.contentWidth, display.contentHeight )
   noteBackground.x, noteBackground.y = display.contentWidth/2, display.contentHeight/2
   sceneGroup:insert( noteBackground )
   
   local note_s = display.newImage( "content/image/note/note_s.png", display.contentWidth, display.contentHeight )
   note_s.x, note_s.y = 100,100
   sceneGroup:insert( note_s )

   local diary = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   diary.x, diary.y = display.contentWidth*0.212, display.contentHeight*0.36
   sceneGroup:insert( diary )

   local message = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   message.x, message.y = display.contentWidth*0.31, display.contentHeight*0.36
   sceneGroup:insert( message )

   local wear = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   wear.x, wear.y = display.contentWidth*0.41, display.contentHeight*0.36
   sceneGroup:insert( wear )

   local mouth = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   mouth.x, mouth.y = display.contentWidth*0.212, display.contentHeight*0.54
   sceneGroup:insert( mouth )

   local drink = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   drink.x, drink.y = display.contentWidth*0.31, display.contentHeight*0.54
   sceneGroup:insert( drink )

   local poison = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   poison.x, poison.y = display.contentWidth*0.41, display.contentHeight*0.54
   sceneGroup:insert( poison)

   local suspect = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   suspect.x, suspect.y = display.contentWidth*0.212, display.contentHeight*0.72
   sceneGroup:insert( suspect )

   local bankbook = display.newImage( "content/image/note/none.png", display.contentWidth, display.contentHeight )
   bankbook.x, bankbook.y = display.contentWidth*0.31, display.contentHeight*0.72
   sceneGroup:insert( bankbook )

   --사진--
   
   local diary1 = display.newImage( "content/image/note/diary.png", display.contentWidth, display.contentHeight )
   diary1.x, diary1.y = display.contentWidth*0.212, display.contentHeight*0.36
   sceneGroup:insert( diary1 )
   diary1:addEventListener("tap",touch1)
   diary1.alpha = 0
   local num = composer.getVariable("clue6")
   if num == 1 then 
      diary1.alpha = 1
   end


   local message1 = display.newImage( "content/image/note/message.png", display.contentWidth, display.contentHeight )
   message1.x, message1.y = display.contentWidth*0.31, display.contentHeight*0.36
   sceneGroup:insert( message1 )
   message1:addEventListener("tap",touch2)
   message1.alpha = 0
   num = composer.getVariable("clue5")
   if num == 1 then 
      message1.alpha = 1   
   end

   local wear1 = display.newImage( "content/image/note/wear.png", display.contentWidth, display.contentHeight )
   wear1.x, wear1.y = display.contentWidth*0.41, display.contentHeight*0.36
   sceneGroup:insert( wear1 )
   wear1:addEventListener("tap",touch3)
   wear1.alpha = 0
   num = composer.getVariable("clue4")
   if num == 1 then 
      wear1.alpha = 1
   end

   local mouth1 = display.newImage( "content/image/note/mouth.png", display.contentWidth, display.contentHeight )
   mouth1.x, mouth1.y = display.contentWidth*0.212, display.contentHeight*0.54
   sceneGroup:insert( mouth1 )
   mouth1:addEventListener("tap",touch4)
   mouth1.alpha = 0
   num = composer.getVariable("clue2")
   if num == 1 then 
      mouth1.alpha = 1
   end


   local drink1 = display.newImage( "content/image/note/drink.png", display.contentWidth, display.contentHeight )
   drink1.x, drink1.y = display.contentWidth*0.31, display.contentHeight*0.54
   sceneGroup:insert( drink1 )
   drink1:addEventListener("tap",touch5)
   drink1.alpha = 0
   num = composer.getVariable("clue3")
   if num == 1 then 
      drink1.alpha = 1
   end


   local poison1 = display.newImage( "content/image/note/poison.png", display.contentWidth, display.contentHeight )
   poison1.x, poison1.y = display.contentWidth*0.41, display.contentHeight*0.54
   sceneGroup:insert( poison1)
   poison1:addEventListener("tap",touch6)
   poison1.alpha = 0
   local num = composer.getVariable("clue7")
   if num == 1 then 
      poison1.alpha = 1
   end

   local suspect1 = display.newImage( "content/image/note/suspect.png", display.contentWidth, display.contentHeight )
   suspect1.x, suspect1.y = display.contentWidth*0.212, display.contentHeight*0.72
   sceneGroup:insert( suspect1 )
   suspect1:addEventListener("tap",touch7)
   suspect1.alpha = 0
   local num = composer.getVariable("clue1")
   if num == 1 then 
      suspect1.alpha = 1
   end

   local bankbook1 = display.newImage( "content/image/note/bankbook.png", display.contentWidth, display.contentHeight )
   bankbook1.x, bankbook1.y = display.contentWidth*0.312, display.contentHeight*0.72
   sceneGroup:insert( bankbook1 )
   bankbook1:addEventListener("tap",touch8)
   bankbook1.alpha = 0
   local num = composer.getVariable("clue8")
   if num == 1 then 
      bankbook1.alpha = 1
   end

   


   local function closeNote(event)
      local scene = composer.getVariable("scene");
      composer.removeScene("note")
      if(scene == 8) then
         composer.gotoScene("searchGong")
      elseif(scene == 1) then
         composer.gotoScene("map1")
      elseif(scene == 2) then
         composer.gotoScene("map2")
      elseif(scene == 3) then
         composer.gotoScene("map3")
      elseif(scene == 4) then
         composer.gotoScene("map4")
      elseif(scene == 6) then
         composer.gotoScene("gayeongHome")
      end
   end
   note_s:addEventListener("tap",closeNote)
   
   -- 레이어 정리
   sceneGroup:insert(title)
   sceneGroup:insert(explain)
end
 

---------------------------------------------------------------------------------

-- Listener setup

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene