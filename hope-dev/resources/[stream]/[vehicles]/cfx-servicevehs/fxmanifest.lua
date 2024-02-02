fx_version "cerulean"
game "gta5"

lua54 "yes"

author "Klaus"

description "Service Car's"

version "Hope Cars"

files {	
	'audio/*',
	'audio/**/*',
    'data/**/carcols.meta',
    'data/**/carvariations.meta',
    'data/**/handling.meta',
    'data/**/vehicles.meta'
}

data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')

data_file "AUDIO_SYNTHDATA" "audio/bmwm3/s55b30_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/bmwm3/s55b30_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/bmwm3/s55b30_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/bmwm3/dlc_s55b30"

data_file "AUDIO_SYNTHDATA" "audio/bmwm5/s63b44_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/bmwm5/s63b44_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/bmwm5/s63b44_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/bmwm5/dlc_s63b44"

data_file "AUDIO_SYNTHDATA" "audio/jettagli/ea888_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/jettagli/ea888_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/jettagli/ea888_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/jettagli/dlc_ea888"

data_file "AUDIO_SYNTHDATA" "audio/tundra/chevydmaxeng_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/tundra/chevydmaxeng_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/tundra/chevydmaxeng_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/tundra/dlc_chevydmaxeng"