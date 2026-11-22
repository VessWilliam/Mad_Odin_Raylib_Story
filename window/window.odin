package window

import rl "vendor:raylib"

WindowControl :: proc() {
	if rl.IsKeyPressed(.F11) {
		if rl.IsWindowMaximized() {
			rl.RestoreWindow()
			return
		}
		rl.MaximizeWindow()
	}
}
