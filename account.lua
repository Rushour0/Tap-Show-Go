local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- create a white bkg to fill screen
	local bkg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bkg:setFillColor( 1 )	-- white
	
	-- add the bkg AndroidResources/img
	local bkgimg = display.newImageRect("img/blank.png", display.contentWidth, display.contentHeight)
	bkgimg.x = display.contentCenterX
	bkgimg.y = display.contentCenterY

	-- create title text
	local headText = display.newText( "My Account", display.contentCenterX, display.contentHeight/9, default_font_bold )
	headText.size = 36
	headText:setFillColor( 1 )	-- white

	local usernameText = display.newText( "Username : " .. default_username , display.contentCenterX, display.contentHeight/9 + 50, default_font )
	usernameText.size = 18
	usernameText:setFillColor( 1 )

	local scenenames = {"schedule", "visits", "grants","visitors", "settings"}

	-- goto functions

	local function popup( event )
		if ( event.action == "clicked" ) then
	        local i = event.index
			if ( i == 1 ) then
				-- Do nothing; dialog will simply dismiss
			elseif ( i == 2 ) then
				os.exit( 0 )
				composer.gotoScene( "login" , {time = 400, effect = "fromRight"} )
			end
		end
	end

	local function gotoLogin( event )
		local phase = event.phase
		if ( phase == "ended" ) then
			system.vibrate()
			native.showAlert( "Exit Screen","Do you want to exit?", { "No", "Yes" }, popup )
		end
	end
	
	local function gotoSubProcess( event )
		local phase = event.phase
		if ( phase == "ended" ) then
			print(event.target.id)
			composer.gotoScene( scenenames[event.target.id] , {time = 400, effect = "fromRight"})
		end
	end

	-- Buttons

	local logoutButton = widget.newButton(
		{
			width = 36,
			label = "", 
			height = 36,
			labelColor = { default={ 1.0 }, over={ 0.5 } },
			defaultFile = "img/logout.png",
			overFile = "img/logout.png",
			onEvent = gotoLogin
			-- Properties for a rounded rectangle button
		})

	logoutButton.x = display.contentWidth/10
	logoutButton.y = display.contentHeight/10

	local actionNames = {"SCHEDULING", "PREVIOUS VISITS", "GRANT PERMISSIONS", "VISITORS", "SETTINGS"}
	local buttons = {}
	for i,v in ipairs(actionNames) do
		buttons[#buttons + 1] = widget.newButton(
		{
			label = v,
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			id = i,
			fontSize = 18,
			onEvent = gotoSubProcess,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			cornerRadius = 10,
			fillColor = { default={1,1,1,1}, over={0.9,0.9,0.9,0.9} },
			x = display.contentCenterX, 
			y = display.contentCenterY - 20 - display.contentHeight/8 + (display.contentHeight/8)*(i-1), 
			width = display.contentWidth*5/6, 
			height = display.contentHeight/10,
			font = default_font_bold
		})
	end

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bkg )
	sceneGroup:insert( bkgimg )
	sceneGroup:insert( headText )
	sceneGroup:insert( usernameText )
	sceneGroup:insert( logoutButton )
	sceneGroup:insert( buttons[1] )
	sceneGroup:insert( buttons[2] )
	sceneGroup:insert( buttons[3] )
	sceneGroup:insert( buttons[4] )
	sceneGroup:insert( buttons[5] )

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