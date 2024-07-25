const std = @import("std");
const Engine = @import("engine.zig").Engine;

pub fn main() !void {
    var engine = try Engine.init();
    defer engine.deinit();
    try engine.run();
}
