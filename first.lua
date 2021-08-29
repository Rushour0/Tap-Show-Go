local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- create a white background to fill screen
	local bkg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bkg:setFillColor( 1 )	-- white
	
	local bkgimg = display.newImageRect("img/first.jpg", system.ResourceDirectory, display.contentWidth, display.contentHeight)
	bkgimg.x = display.contentCenterX
	bkgimg.y = display.contentCenterY

	local logo = display.newImageRect("img/logo.png", system.ResourceDirectory, display.contentWidth, display.contentHeight)
	logo.x = display.contentCenterX
	logo.y = display.contentHeight/3

	local welcomeText = display.newText("Tap-Show-Go",display.contentCenterX, display.contentCenterY , default_font_bold)
	welcomeText.size = 24
	welcomeText:setFillColor( 1 )
	
	local arrowImage = display.newImageRect("img/arrow.png", system.ResourceDirectory, 48, 85)
	arrowImage.x = display.contentWidth - 25
	arrowImage.y = display.contentHeight - 30

	local function gotoLogin( event )
		local phase = event.phase
		if (phase == "ended") then
			composer.gotoScene(	"login" , {time = 400, effect = "fromRight"} )
		end
	end

	-- Create the widget - Load Pro Heroes
	local login_button = widget.newButton(
		{
			label = "Login",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 20,
			onEvent = gotoLogin,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 150,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={0.8,0.8,0.8,0}, over={0.6,0.6,0.6,0} },
			
			font = default_font,
			x = display.contentWidth - 75,
			y = display.contentHeight - 30
		})
 

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bkg )
	sceneGroup:insert( bkgimg )
	sceneGroup:insert( logo )
	sceneGroup:insert( welcomeText )
	sceneGroup:insert( login_button )
	sceneGroup:insert( arrowImage )


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
		display.remove(usernameText)
		display.remove(passwordText)
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