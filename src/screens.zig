const std = @import("std");
const utilities = @import("utils.zig");
const g = @import("graphics.zig");
const rl = @import("libs/raylib-zig/raylib.zig");

pub const ScreenManager = struct {
    currentScreen: Screen,

    pub const Screen = enum {
        TitleScreen,
        BattleScreen,
        OptionsScreen,
        NewGame,
    };

    pub fn AddScreen(self: *ScreenManager, new_screen: Screen) !void {
        self.Layers.push(new_screen);
    }

    pub fn RemoveScreen(self: *ScreenManager) !void {
        try self.Layers.pop();
    }

    pub fn NewGame(gfx: *g.Graphics) void {
        //we are going to build a 5x5 grid and make travers cell by cell row by row coloring a cell
        if (rl.isKeyDown(rl.KeyboardKey.key_backspace)) {
            gfx.sm.currentScreen = Screen.TitleScreen;
        }

        const size = 5;

        const buttonWidth: i32 = 50;
        const buttonHeight: i32 = 50;

        //define button collors
        const buttonColor = rl.Color.light_gray;
        const textColor = rl.Color.black;

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);
        std.debug.print("renderHeight: {}\n", .{rl.getRenderHeight()});
        for (0..size) |row| {
            for (0..size) |col| {
                const r: i32 = @intCast(row);
                const c: i32 = @intCast(col);
                const posX: i32 = c * 50;
                const posY: i32 = c * r * 50;
                const buttonRect = rl.Rectangle{
                    .x = @floatFromInt(posX),
                    .y = @floatFromInt(posY),
                    .width = buttonWidth,
                    .height = buttonHeight,
                };

                rl.drawRectangleRec(buttonRect, buttonColor);
                const textWidth = rl.measureText("Box", 20);
                rl.drawText("Box", posX + @divTrunc(buttonWidth, 2) - @divTrunc(textWidth, 2), posY + @divTrunc(buttonHeight, 2) - 10, 20, textColor);
            }
        }
    }

    pub fn Options(gfx: *g.Graphics) void {
        const buttonWidth: i32 = 200;
        const buttonHeight: i32 = 50;
        const buttonTexts = [_][*:0]const u8{"Toggle Fullscreen"};
        const buttonCount: i32 = buttonTexts.len;

        //define button collors
        const buttonColor = rl.Color.light_gray;
        const textColor = rl.Color.black;
        const hoverColor = rl.Color.gray;

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);
        std.debug.print("renderHeight: {}\n", .{rl.getRenderHeight()});
        for (buttonTexts, 0..) |btn, index| {
            const ind: i32 = @intCast(index);
            const v: i32 = @divTrunc(rl.getRenderWidth(), 2) - buttonWidth / 2;
            const posX: i32 = v;
            const posY: i32 = @divTrunc(rl.getRenderHeight(), 2) - buttonHeight * @divTrunc(buttonCount, 2) + (ind * (buttonHeight + 10));

            const buttonRect = rl.Rectangle{
                .x = @floatFromInt(posX),
                .y = @floatFromInt(posY),
                .width = buttonWidth,
                .height = buttonHeight,
            };

            if (rl.isKeyDown(rl.KeyboardKey.key_backspace)) {
                gfx.sm.currentScreen = Screen.TitleScreen;
            }

            if (rl.checkCollisionPointRec(rl.getMousePosition(), buttonRect)) {
                if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_left)) {
                    switch (index) {
                        0 => {
                            rl.toggleFullscreen();
                        },
                        else => {},
                    }
                }
                rl.drawRectangleRec(buttonRect, hoverColor);
            } else {
                rl.drawRectangleRec(buttonRect, buttonColor);
            }

            const textWidth = rl.measureText(btn, 20);
            rl.drawText(btn, posX + @divTrunc(buttonWidth, 2) - @divTrunc(textWidth, 2), posY + @divTrunc(buttonHeight, 2) - 10, 20, textColor);
        }
    }

    pub fn TitleScreen(gfx: *g.Graphics) void {
        const buttonWidth: i32 = 200;
        const buttonHeight: i32 = 50;
        const buttonTexts = [_][*:0]const u8{ "New Game", "Continue", "Options", "Quit" };
        const buttonCount: i32 = buttonTexts.len;

        //define button collors
        const buttonColor = rl.Color.light_gray;
        const textColor = rl.Color.black;
        const hoverColor = rl.Color.gray;

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);
        std.debug.print("renderHeight: {}\n", .{rl.getRenderHeight()});
        for (buttonTexts, 0..) |btn, index| {
            const ind: i32 = @intCast(index);
            const v: i32 = @divTrunc(rl.getRenderWidth(), 2) - buttonWidth / 2;
            const posX: i32 = v;
            const posY: i32 = @divTrunc(rl.getRenderHeight(), 2) - buttonHeight * @divTrunc(buttonCount, 2) + (ind * (buttonHeight + 10));

            const buttonRect = rl.Rectangle{
                .x = @floatFromInt(posX),
                .y = @floatFromInt(posY),
                .width = buttonWidth,
                .height = buttonHeight,
            };

            if (rl.checkCollisionPointRec(rl.getMousePosition(), buttonRect)) {
                if (rl.isMouseButtonPressed(rl.MouseButton.mouse_button_left)) {
                    switch (index) {
                        0 => {
                            gfx.sm.currentScreen = Screen.NewGame;
                        },
                        2 => {
                            gfx.sm.currentScreen = Screen.OptionsScreen;
                        },
                        3 => {
                            rl.closeWindow();
                        },
                        else => {},
                    }
                }
                rl.drawRectangleRec(buttonRect, hoverColor);
            } else {
                rl.drawRectangleRec(buttonRect, buttonColor);
            }

            const textWidth = rl.measureText(btn, 20);
            rl.drawText(btn, posX + @divTrunc(buttonWidth, 2) - @divTrunc(textWidth, 2), posY + @divTrunc(buttonHeight, 2) - 10, 20, textColor);
        }
    }

    pub fn init() ScreenManager {
        return ScreenManager{
            .currentScreen = Screen.TitleScreen,
        };
    }
};
