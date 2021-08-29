local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- create a white background to fill screen
	local bkg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bkg:setFillColor( 1 )	-- white
	
	-- create a background image
	local bkgimg = display.newImageRect("img/schedule.jpg", system.ResourceDirectory, display.contentWidth, display.contentHeight)
	bkgimg.x = display.contentCenterX
	bkgimg.y = display.contentCenterY

	-- headText 
	local headText = display.newText( "Schedule", display.contentCenterX, display.contentHeight/9 , default_font_bold )
	headText.size = 28
	headText:setFillColor( 1 )
	
	--[[
	local calendar = display.newImageRect("img/calendar.png", system.ResourceDirectory, display.contentWidth*14/18, display.contentHeight*14/18)
	calendar.x = display.contentCenterX
	calendar.y = display.contentCenterY + display.contentWidth/6
	--]]

	-- gotoAccount function to the account scene
	local function gotoAccount( event )
		local phase = event.phase
		if (phase == "ended") then
			composer.gotoScene( "account" , {time = 400, effect = "fromLeft"})
		end
	end

	-- Buttons

	local checkButton = widget.newButton(
		{
			label = "CHECK",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 20,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 150,
			height = 40,
			cornerRadius = 20,
			fillColor = { default={0.9764705882352941,0.6196078431372549,0.11372549019607843,1}, over={0.8788235294117646,0.5576470588235294,0.10235294117647058,1} },
			
			font = default_font,
			x = display.contentCenterX,
			y = display.contentHeight - display.contentHeight/6
		})

	local backButton = widget.newButton(
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
		})

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bkg )
	sceneGroup:insert( bkgimg )
	sceneGroup:insert( headText )
	sceneGroup:insert( checkButton )
--	sceneGroup:insert( calendar )
	sceneGroup:insert( backButton )



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