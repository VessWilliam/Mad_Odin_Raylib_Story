package ui
import "../constant"
import rl "vendor:raylib"


Init :: proc(){
	soul_png = rl.LoadTexture(constant.ACTOR_PNG)
}

Shutdown :: proc(){
	rl.UnloadTexture(soul_png)
}

Camera :: proc() -> rl.Camera2D {
	return rl.Camera2D {
		offset = {
			(f32(rl.GetScreenWidth()) - constant.UI_WIDTH) / 2,
			(f32(rl.GetScreenHeight()) - constant.UI_HEIGHT) / 2,
		},
		zoom = 1,
	}
}


DrawBattleUI :: proc(state: constant.State) {
	draw_terrain(state)
    draw_character(state)
    draw_menu_buttons()
    draw_stats(state.player_hp, state.max_hp)
}

@(private)
draw_terrain :: proc(state: constant.State){
	if state.phase == .BATTLE{
		rl.DrawRectangleLinesEx(state.battle_box, 4, constant.COLOR_BOX)
		return
	}
}


@(private)
draw_character :: proc(state : constant.State) {
    half := f32(constant.SOUL_SIZE) / 2
	rl.DrawTexturePro(soul_png,
	 rl.Rectangle{0, 0, f32(soul_png.width), f32(soul_png.height)},
     rl.Rectangle{
         state.soul_pos.x - half,
         state.soul_pos.y - half,
         constant.SOUL_SIZE,
         constant.SOUL_SIZE
     },
     {0,0},
     0,
     rl.WHITE
	)
}


@(private)
draw_stats :: proc(hp, max_hp: i32) {
	ratio := clamp(f32(hp) / f32(max_hp), 0, 1)
	bar_x: f32 = 240

	rl.DrawText("CHARA  LV1", constant.MARGIN, constant.STATS_Y, 20, constant.COLOR_BOX)
	rl.DrawText("HP", 200, constant.STATS_Y, 20, constant.COLOR_BOX)
	rl.DrawRectangleRec(
		{bar_x, constant.STATS_Y + 2, constant.HP_BAR_W, constant.HP_BAR_H},
		rl.DARKGRAY,
	)
	rl.DrawRectangleRec(
		{bar_x, constant.STATS_Y + 2, constant.HP_BAR_W * ratio, constant.HP_BAR_H},
		constant.COLOR_HP_BAR,
	)
	rl.DrawText(
		rl.TextFormat("%d / %d", hp, max_hp),
		310,
		constant.STATS_Y,
		20,
		constant.COLOR_BOX,
	)
}

@(private)
draw_menu_buttons :: proc(){
	for label, i in constant.BOTTON_LABEL {
		btn_x := constant.MARGIN + f32(i) * (constant.BUTTON_W + constant.BUTTON_GAP)

		draw_button(
			rl.Rectangle {
				x = btn_x,
				y = constant.BUTTON_Y,
				width = constant.BUTTON_W,
				height = constant.BUTTON_H,
			},
			label,
		)
	}
}

@(private)
draw_button :: proc(rect: rl.Rectangle, text: cstring) {
	rl.DrawRectangleLinesEx(rect, 3, constant.COLOR_BUTTON)
	rl.DrawText(text, i32(rect.x) + 10, i32(rect.y) + 10, 24, constant.COLOR_BUTTON)
}

@(private)
soul_png: rl.Texture2D
