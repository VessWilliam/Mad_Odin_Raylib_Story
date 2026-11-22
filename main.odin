package main

import "game"
import "ui"
import rl "vendor:raylib"
import "window"

SCREEN_W :: 1920
SCREEN_H :: 1080

main :: proc() {

	rl.SetConfigFlags({.WINDOW_RESIZABLE})

	rl.InitWindow(SCREEN_W, SCREEN_H, "Mad UNdertale")
	defer rl.CloseWindow()
	rl.SetTargetFPS(60)

	ui.Init()
	defer ui.Shutdown()

	state := game.GameInit(rl.Rectangle{x = 20, y = -120, width = 600, height = 300})

	for !rl.WindowShouldClose() {
		window.WindowControl()

		game.Update(&state, rl.GetFrameTime())

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.BeginMode2D(ui.Camera())
		ui.DrawBattleUI(state)
		rl.EndMode2D()
		rl.EndDrawing()
	}
}
