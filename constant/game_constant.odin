package constant

import rl "vendor:raylib"

SOUL_SIZE : f32 = 44.0
BOX_PADDING : f32 = 4.0

//Enum
GamePhase :: enum{
	BATTLE,
	ESCAPE,
	WIN
}

//Struct
State :: struct{
	 soul_pos: rl.Vector2,
	 soul_speed: f32,
	 player_hp: i32,
	 max_hp: i32,
	 battle_box: rl.Rectangle,
	 phase: GamePhase,
}
