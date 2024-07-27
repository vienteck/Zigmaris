const std = @import("std");
const ScreenManager = @import("screens.zig").ScreenManager;
const rl = @import("libs/raylib-zig/raylib.zig");

pub const Graphics = struct {
    sm: ScreenManager,
    var screenWidth: i32 = 800;
    var screenHeight: i32 = 450;

    pub fn init() !Graphics {
        // screenWidth = rl.getMonitorWidth(0);
        // screenHeight = rl.getMonitorHeight(0);

        rl.initWindow(screenWidth, screenHeight, "Zigmaris");
        rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

        return Graphics{
            .sm = ScreenManager.init(),
        };
    }

    pub fn deinit(self: *Graphics) void {
        // Cleanup graphics context
        _ = self;
    }

    pub fn clear(self: *Graphics) void {
        // Clear the screen
        std.debug.print("\x1b[2J\x1b[H", .{}); // Clear screen and move cursor to home position
        _ = self;
    }

    pub fn present(self: *Graphics) void {
        // Present the rendered frame
        std.debug.print("Widht {} Height {}\n", .{ screenWidth, screenHeight });
        switch (self.sm.currentScreen) {
            ScreenManager.Screen.NewGame => ScreenManager.NewGame(self),
            ScreenManager.Screen.TitleScreen => ScreenManager.TitleScreen(self),
            ScreenManager.Screen.OptionsScreen => ScreenManager.Options(self),
            else => std.debug.print("Unknown state", .{}),
        }
    }
};
fn encase(msg: []const u8) void {
    std.debug.print("->{s}", .{msg});
}
