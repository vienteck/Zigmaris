const std = @import("std");
const Graphics = @import("graphics.zig").Graphics;
const Input = @import("input.zig").Input;
const rl = @import("raylib");

pub const Engine = struct {
    gfx: Graphics,
    input: Input,

    pub fn init() !Engine {
        return Engine{
            .gfx = try Graphics.init(),
            .input = try Input.init(),
        };
    }

    pub fn deinit(self: *Engine) void {
        self.gfx.deinit();
        self.input.deinit();
    }

    pub fn run(self: *Engine) !void {
        self.gfx.clear();

        while (true) {
            try self.input.pollEvents();
            self.update();
            self.render();
        }
    }

    fn update(self: *Engine) void {
        // Update game state
        _ = self;
    }

    fn render(self: *Engine) void {
        self.gfx.clear();
        // Render game
        self.gfx.present();
    }
};
