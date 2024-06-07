extends Popup

#Graphics
@onready var display_mode_dd = $SettingsTabs/Graphics/MarginContainer/GraphicsSettings/DisplayModeDD

#Audio
@onready var master_audio = $SettingsTabs/Audio/MarginContainer/AudioSettings/MasterAudio
@onready var music_audio = $SettingsTabs/Audio/MarginContainer/AudioSettings/MusicAudio
@onready var sfx_audio = $SettingsTabs/Audio/MarginContainer/AudioSettings/SFXAudio

# Called when the node enters the scene tree for the first time.
func _ready():
	display_mode_dd.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSettings.toggle_fullscreen(3 if Save.game_data.fullscreen_on else 0)
	
	master_audio.value = Save.game_data.master_vol
	music_audio.value = Save.game_data.music_vol
	sfx_audio.value = Save.game_data.sfx_vol



func _on_display_mode_dd_item_selected(index):
	GlobalSettings.toggle_fullscreen(3 if index == 1 else 0)


func _on_master_audio_value_changed(value):
	GlobalSettings.update_master_vol(value)


func _on_music_audio_value_changed(value):
	GlobalSettings.update_music_vol(value)


func _on_sfx_audio_value_changed(value):
	GlobalSettings.update_sfx_vol(value)
