const std = @import("std");
const ScreenManager = @import("screens.zig");

pub const Graphics = struct {
    screen: ScreenManager.Screen,
    screen_selection: u8,

    pub fn init() !Graphics {
        // Initialize graphics context
        return Graphics{
            .screen = ScreenManager.Screen.TitleScreen,
            .screen_selection = 0,
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
        //
        switch (self.screen) {
            ScreenManager.Screen.TitleScreen => TitleScreen(0),
            else => std.debug.print("Unknown state", .{}),
        }
    }
};

fn TitleScreen(selection: i8) void {
    // if (selection < 0) {
    //     selection = 0;
    // } else if (selection > 2) {
    //     selection = 2;
    // }
    std.debug.print("This is the title Screen\n", .{});
    var text: []const u8 = "New Game\n";
    if (selection == 0) {
        encase(text);
    } else {
        std.debug.print("{s}", .{text});
    }

    text = "Continue\n";
    if (selection == 1) {
        encase(text);
    } else {
        std.debug.print("{s}", .{text});
    }

    text = "Quit\n";
    if (selection == 2) {
        encase(text);
    } else {
        std.debug.print("{s}", .{text});
    }
}

fn encase(msg: []const u8) void {
    std.debug.print("->{s}", .{msg});
}
