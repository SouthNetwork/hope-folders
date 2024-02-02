
fx_version "bodacious"
game "gta5"

ui_page "web/build/index.html"

lua54 'yes'

author 'HOPE'
description 'Sistema de tablet policial para efetuar prisões, aplicar multas, verificar ficha criminal e checar código penal'

client_script {
  "@vrp/lib/Native.lua",
  "@PolyZone/client.lua",
  "@vrp/lib/Utils.lua",
  "config/config.lua",
  "client/**/*"
}

server_scripts {
  "@vrp/lib/itemlist.lua",
  "@vrp/lib/Utils.lua",
  "config/config.lua",
  "server/**/*"
}

files {
  "web/build/*",
  "web/build/**/*",
}