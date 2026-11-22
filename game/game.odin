package game

import "../constant"
import rl "vendor:raylib"

GameInit :: proc(battle_box: rl.Rectangle) -> constant.State {
	state := constant.State {
		soul_pos   = {battle_box.x + battle_box.width / 2, battle_box.y + battle_box.height / 2},
		soul_speed = 200.0,
		player_hp  = 20,
		max_hp     = 20,
		battle_box = battle_box,
	}

	return state
}

Update :: proc(state: ^constant.State, dt: f32) {
	player_movement(state, dt)
}


@(private)
player_movement :: proc(state: ^constant.State, dt: f32) {
	dir := rl.Vector2{0, 0}
	// Movement
	if rl.IsKeyDown(.UP) || rl.IsKeyDown(.W) {dir.y -= 1}
	if rl.IsKeyDown(.DOWN) || rl.IsKeyDown(.S) {dir.y += 1}
	if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) {dir.x -= 1}
	if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) {dir.x += 1}

	state.soul_pos += dir * state.soul_speed * dt
	clamping_soul_pos(state)
}


@(private)
clamping_soul_pos :: proc(state: ^constant.State) {
	inset := constant.BOX_PADDING + constant.SOUL_SIZE / 2
	b := state.battle_box
	state.soul_pos.x = clamp(state.soul_pos.x, b.x + inset, b.x + b.width - inset)
	state.soul_pos.y = clamp(state.soul_pos.y, b.y + inset, b.y + b.height - inset)
}
