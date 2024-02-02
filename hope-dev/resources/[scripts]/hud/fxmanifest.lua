fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

name 'Hud Hope'
author 'Klaus'
version '1.0'

client_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"@vrp/lib/Native.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}