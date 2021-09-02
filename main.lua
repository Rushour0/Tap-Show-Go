-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- include Corona's "widget" library
widget = require "widget"
composer = require "composer"

default_username = "admin"
default_password = "admin"

default_font = "fonts/MontserratRegular.otf"
default_font_bold = "fonts/MontserratExtrabold.otf"

composer.loadScene( "login" )
composer.loadScene( "account" )
composer.loadScene( "schedule" )
composer.loadScene( "visitors" )
composer.loadScene( "visits" )
composer.loadScene( "grants" )
composer.loadScene( "settings" )

composer.gotoScene( "first" , {time = 400, effect = "fromRight"})


