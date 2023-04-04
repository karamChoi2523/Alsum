-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
   local sceneGroup = self.view

   

   doummal= display.newText("알섬으로는 본격 추리 게임입니다.\n\n살인 트릭을 찾고 범인을 \n찾아내는 것이 게임의 목표입니다.\n\n사건현장에서 결정적인 단서를 찾고\n용의자를 심문하십시오.\n\n단서와 알섬 사람들의 대화를 통해\n용의자를 추궁하여 범인과 트릭에\n대해서 알아낼 수 있습니다.\n\n사용 방법 : \n방향키를 통해 이동 가능하고\n조사를 원할 땐 엔터키를 누르시오.",140,350)
   doummal.anchorX,doummal.anchorY = 0,0
   doummal:setFillColor(1)
   doummal.alpha = 0
   doummal.size = 30


   local background = display.newImage( "content/image/main/startBackground.png", display.contentWidth, display.contentHeight )
   background.x, background.y = display.contentWidth/2, display.contentHeight/2
   sceneGroup:insert( background )


   
   local help = display.newImage( "content/image/main/help.png", display.contentWidth, display.contentHeight )
   help.x, help.y = display.contentWidth*0.17, display.contentHeight/2
   sceneGroup:insert( help )
   help.alpha = 0
   

   local function touch1(event)
      composer.setVariable("toMap1", 0)
      composer.removeScene("start")
      doummal.alpha = 0
      composer.gotoScene( "prologue" )

   end

   local function touch2(event)
      
      if help.alpha == 0 then
         help.alpha = 1
         doummal.alpha = 1
      else
         help.alpha = 0
         doummal.alpha = 0
      end
  end


   local function touch3(event)
      composer.removeScene("start")
      doummal.alpha = 0
      composer.gotoScene( "view1" )

   end


   local startB = display.newImage( "content/image/main/startB.png", display.contentWidth, display.contentHeight )
   startB.x, startB.y = display.contentWidth/2, display.contentHeight*0.73
   sceneGroup:insert( startB )
   startB:addEventListener("tap",touch1)
   


   local helpB = display.newImage( "content/image/main/helpB.png", display.contentWidth, display.contentHeight )
   helpB.x, helpB.y = display.contentWidth/2, display.contentHeight*0.83
   sceneGroup:insert( helpB )
   helpB:addEventListener("tap",touch2)


   local exitB = display.newImage( "content/image/main/exitB.png", display.contentWidth, display.contentHeight )
   exitB.x, exitB.y = display.contentWidth/2, display.contentHeight*0.93
   sceneGroup:insert( exitB )
   exitB:addEventListener("tap",touch3)

   -- all objects must be added to group (e.g. self.view)
   
end



---------------------------------------------------------------------------------

-- Listener setup

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene