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
        // Initialization
        //--------------------------------------------------------------------------------------
        const screenWidth = 800;
        const screenHeight = 450;

        rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
        defer rl.closeWindow(); // Close window and OpenGL context

        rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
        //--------------------------------------------------------------------------------------

        // Main game loop
        while (!rl.windowShouldClose()) { // Detect window close button or ESC key
            // Update
            //----------------------------------------------------------------------------------
            // TODO: Update your variables here
            //----------------------------------------------------------------------------------

            // Draw
            //----------------------------------------------------------------------------------
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.white);

            rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.Color.light_gray);
            //----------------------------------------------------------------------------------
        }
        // while (true) {
        //     try self.input.pollEvents();
        //     self.update();
        //     self.render();
        // }
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
