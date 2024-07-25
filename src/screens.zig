const std = @import("std");
const utilities = @import("utils.zig");

pub const Screen = enum {
    TitleScreen,
    BattleScene,
};

const ScreenManager = struct {
    Layers: utilities.Stack,

    pub fn AddScreen(self: *ScreenManager, new_screen: Screen) !void {
        self.Layers.push(new_screen);
    }

    pub fn RemoveScreen(self: *ScreenManager) !void {
        try self.Layers.pop();
    }
};
