const std = @import("std");

pub const Graphics = struct {
    screen: Screen,
    screen_selection: u8,

    const Screen = enum {
        TitleScreen,
        BattleScene,
    };

    pub fn init() !Graphics {
        // Initialize graphics context
        return Graphics{
            .screen = .TitleScreen,
            .screen_selection = 0,
        };
    }

    pub fn deinit(self: *Graphics) void {
        // Cleanup graphics context
        _ = self;
    }

    pub fn clear(self: *Graphics) void {
        // Clear the screen
        _ = self;
        std.debug.print("\x1b[2J\x1b[H", .{}); // Clear screen and move cursor to home position
    }

    pub fn present(self: *Graphics) void {
        // Present the rendered frame
        //
        switch (self.screen) {
            Screen.TitleScreen => TitleScreen(0),
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
