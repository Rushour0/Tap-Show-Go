local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()
local usernameText
local passwordText

function scene:create( event )
	local sceneGroup = self.view

	-- create a white background to fill screen
	local bkg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bkg:setFillColor( 1 )	-- white
	
	-- add the background AndroidResources/img
	local bkgimg = display.newImageRect("img/login.png", system.ResourceDirectory, display.contentWidth, display.contentHeight)
	bkgimg.x = display.contentCenterX 
	bkgimg.y = display.contentCenterY

	-- add the college logo
	local collegeLogo = display.newImageRect("img/mitwpu-logo.png", system.ResourceDirectory, 490/2.01 ,210/2.01)
	collegeLogo.x = display.contentCenterX + display.contentWidth/4
	collegeLogo.y = display.contentHeight - 20
 	
	-- add the head text
	local headText = display.newText("LOG IN", display.contentCenterX, display.contentHeight/9, default_font_bold )
	headText.size = 28
	headText:setFillColor( 1 )

	-- add the notify text
	local notifyText = display.newText("", display.contentCenterX, display.contentCenterY - display.contentWidth/4, default_font )
	notifyText.size = 16
	notifyText:setFillColor( 1, 0, 0 )
	
	-- goto function
	local function gotoFirst( event )
		local phase = event.phase
		if (phase == "ended") then
			composer.gotoScene( "first" , {time = 400, effect = "fromLeft"})
		end
	end

	-- check for the login click
	local function LoginClick( event )
		local phase = event.phase
		if (phase == "ended") then
			if ( usernameText.text == default_username and passwordText.text == default_password) then
				native.setKeyboardFocus( nil )
				composer.gotoScene(	"account", {time = 400, effect = "fromRight"} )
			else
				notifyText.text = "wrong username or password!"
			end
		end
	end

	-- display password on press
	local function ShowPasswordClick( event )
		local phase = event.phase
		if ( phase == "began") then
			passwordText.isSecure = false
		else
			passwordText.isSecure = true
		end
	end
	
	-- Create widget - back button
	local backButton = widget.newButton(
		{
			width = 48,
			label = "", 
			height = 85,
			labelColor = { default={ 1.0 }, over={ 0.5 } },
			fillColor = {default = {0,0,0,0}, over = {0,0,0,0.5}},
			defaultFile = "img/back.png",
			overFile = "img/back.png",
			onEvent = gotoFirst,
			x = display.contentWidth/10,
			y = display.contentHeight/10
			-- Properties for a rounded rectangle button
		})

	-- Create widget - login button
	local loginButton = widget.newButton(
		{
			label = "LOGIN",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 20,
			onEvent = LoginClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 150,
			height = 40,
			cornerRadius = 20,
			fillColor = { default={0.9764705882352941,0.6196078431372549,0.11372549019607843,1}, over={0.8788235294117646,0.5576470588235294,0.10235294117647058,1} },
			
			font = default_font,
			x = display.contentCenterX,
			y = display.contentCenterY + display.contentWidth/6
		})

	-- Create the widget - showpassword button
	local showPasswordButton = widget.newButton(
		{
			width = 32,
			label = "", 
			height = 32,
			labelColor = { default={ 1.0 }, over={ 0.5 } },
			defaultFile = "img/pass.png",
			overFile = "img/pass-over.png",
			onEvent = ShowPasswordClick
			-- Properties for a rounded rectangle button
		})

	showPasswordButton.x = display.contentCenterX + display.contentWidth/3
	showPasswordButton.y = display.contentHeight/2

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bkg )
	sceneGroup:insert( bkgimg )
	sceneGroup:insert( backButton )
	sceneGroup:insert( collegeLogo )
	sceneGroup:insert( headText )
	sceneGroup:insert( notifyText )
	sceneGroup:insert( loginButton )
	sceneGroup:insert( showPasswordButton )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	local inputGroup = display.newGroup()
	sceneGroup:insert( inputGroup )
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		local function textListener( event )
		 
		    if ( event.phase == "began" ) then
		        -- User begins editing "defaultBox"
		 
		    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- Output resulting text from "defaultBox"
		        print( event.target.text )
		 
		    elseif ( event.phase == "editing" ) then

		        print( event.text )
		    end
		end

		-- username input
		usernameText = native.newTextField( display.contentCenterX, display.contentCenterY - display.contentWidth/6 , display.contentWidth/2, 32 )

		-- password input
		passwordText = native.newTextField( display.contentCenterX, display.contentCenterY, display.contentWidth/2, 32 )

		usernameText.placeholder = "username"
		usernameText.isEditable = true
		usernameText:addEventListener( "userInput", textListener )

		-- passwordText configuration
		passwordText.placeholder = "password"
		passwordText.isEditable = true
		passwordText.isSecure = true
		passwordText:addEventListener( "userInput", textListener )
		-- Called when the scene is now on screen	

		inputGroup:insert( usernameText )
		inputGroup:insert( passwordText )

	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	
	if event.phase == "will" then
		display.remove(usernameText)
		display.remove(passwordText)
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