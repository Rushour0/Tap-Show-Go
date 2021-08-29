local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- create a white background to fill screen
	local bkg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bkg:setFillColor( 1 )	-- white
	
	local bkgimg = display.newImageRect("img/visitors.jpg", system.ResourceDirectory, display.contentWidth, display.contentHeight)
	bkgimg.x = display.contentCenterX
	bkgimg.y = display.contentCenterY

	-- headText 
	local headText = display.newText( "Visitors", display.contentCenterX, display.contentHeight/9 , default_font_bold )
	headText.size = 36
	headText:setFillColor( 1 )

	local function gotoAccount( event )
		local phase = event.phase
		if (phase == "ended") then
			composer.gotoScene( "account" , {time = 400, effect = "fromLeft"})
		end
	end

	-- Create widget - back button
	local back_button = widget.newButton(
		{
			width = 48,
			label = "", 
			height = 85,
			labelColor = { default={ 1.0 }, over={ 0.5 } },
			fillColor = {default = {0,0,0,0}, over = {0,0,0,0.5}},
			defaultFile = "img/back.png",
			overFile = "img/back.png",
			onEvent = gotoAccount,
			x = display.contentWidth/10,
			y = display.contentHeight/10
			-- Properties for a rounded rectangle button
		})

	local function gotoLogin( event )
		local phase = event.phase
		if (phase == "ended") then
			composer.gotoScene(	"login" , {time = 400, effect = "fromRight"} )
		end
	end 

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bkg )
	sceneGroup:insert( bkgimg )
	sceneGroup:insert( headText )
	sceneGroup:insert( back_button )



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