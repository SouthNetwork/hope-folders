fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'maarin'
description 'motoscss'
version '1.0'



escrow_ignore {
    'stream/.ymf',
    'stream/**/.ybn',
    'stream//*.ycd',
    'stream//.ymap',
    'stream/*/.ytyp',

}
dependency '/assetpacks'

files {
	'audio/*',
	'audio/**/*',

	'stream/**/handling.meta',
	'stream/**/vehicles.meta',
	'stream/**/vehiclelayouts.meta',
	'stream/**/carcols.meta',
	'stream/**/carvariations.meta',
} 

data_file 'HANDLING_FILE' 'stream/**/handling.meta'
data_file 'CARCOLS_FILE' 'stream/**/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'stream/**/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'stream/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'stream/**/vehiclelayouts.meta'

data_file "AUDIO_SYNTHDATA" "audio/ea825/ea825_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/ea825/ea825_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/ea825/ea825_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/ea825/dlc_ea825"

dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'